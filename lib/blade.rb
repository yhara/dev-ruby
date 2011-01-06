require 'open-uri'
require 'nokogiri'

class Blade
  def self.update
    latest = self.latest_number
    last = Mail.maximum("number") || (latest - 100)

    puts "last: #{last} latest: #{latest}"

    (last+1).upto(latest) do |i|
      puts "retrieving #{i}..."
      Blade.new(i).create
    end
  end

  def self.latest_number
    doc = Nokogiri::HTML(open(self.latest_index_url).read)
    link = (doc/:a).find_all{|a| a[:href] =~ /scat\.rb/}.last
    link.text.to_i
  end

  def self.latest_index_url
    url = "http://blade.nagaokaut.ac.jp/ruby/ruby-dev/index.shtml"
    doc = Nokogiri::HTML(open(url).read)
    link = (doc/:a).find{|a| a[:href] =~ /\d+-\d+\.shtml/}
    "#{File.dirname(url)}/#{link[:href]}"
  end

  def initialize(number)
    @number = number
  end

  def get
    html = open("http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/#{@number}", "r:euc-jp").read
    html.encode("utf-8")
  end

  def parse
    html = self.get
    doc = Nokogiri::HTML(html)

    header = (doc % "#header").inner_html
    in_reply_to = header[/^In-reply-to: .*?(\d+)/, 1]

    { 
      :number => @number,
      :subject => (doc/:strong)[1].text,
      :from => header[/^From: (.*)<br>$/, 1],  # <- contains html tag
      :time => Time.zone.parse(header[/^Date: (.*)(<br>)?$/, 1]),
      :in_reply_to => (in_reply_to ? in_reply_to.to_i : nil),
      :body => (doc/:pre).inner_html,           # <- contains html tag
    }
  end

  def create
    Mail.create(self.parse)
  end
end
