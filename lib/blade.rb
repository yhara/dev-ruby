require 'open-uri'
require 'nokogiri'

class Blade
  cattr_accessor :verbose
  self.verbose = true

  def self.update
    latest = self.latest_number
    last = Post.maximum("number") || (latest - 100)

    puts "last: #{last} latest: #{latest}" if Blade.verbose

    (last+1).upto(latest) do |i|
      puts "retrieving #{i}..." if Blade.verbose
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
    html = open("http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/#{@number}", "r:binary").read
    html.force_encoding("euc-jp")
    html.encode("utf-8", invalid: :replace, undef: :replace)
  end

  def parse
    html = self.get
    doc = Nokogiri::HTML(html)

    subject = (doc/:strong)[1].text
    header = (doc % "#header").inner_text

    parent_span = (doc % "span[title='[parent]']")
    if parent_span and parent_span.parent.name == "a" # link exists
      parent_no = parent_span.parent[:href].to_i
    else
      parent_no = find_parent_no(subject, @number)
    end

    { 
      :number => @number,
      :subject => subject, 
      :from => header[/^From: (.*)$/, 1],
      :time => Time.zone.parse(header[/^Date: (.*)$/, 1]),
      :in_reply_to => parent_no,
      :body => (doc/:pre).inner_text,
    }
  end

  # parent: [Ruby 1.8-Bug#4206] failed to set ext option for win32/configure.bat
  # me: [Ruby 1.8-Bug#4206] failed to set ext option for win32/configure.bat
  # [Ruby 1.9-Bug#4152]
  def find_parent_no(subject, my_number)
    return nil if subject !~ /\A(\[(.*)-(.*)#(\d*)\])/
    tag = $1
    print "finding `#{tag}'..." if Blade.verbose

    parent = Post.where("subject LIKE (?)", "%#{tag}%").order("number DESC").find{|post| post.number != my_number}

    if parent
      puts "found #{parent.number}" if Blade.verbose
      parent.number
    else
      puts "not found" if Blade.verbose
      nil
    end
  end

  def post
    attrs = self.parse
    attrs[:parent] = Post.find_by_number(attrs.delete(:in_reply_to))
    Post.new(attrs)
  end

  def create
    self.post.save
  end
end
