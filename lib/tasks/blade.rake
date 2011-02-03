require 'yaml'
require 'blade.rb'

Blade.verbose = true

namespace :blade do
  desc "Download blade html to test/data usage: rake blade:get N=42897"
  task :get => :environment do
    raise "N not given" unless ENV["N"]

    n = ENV["N"].to_i
    sh "curl http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/#{n} -o test/data/#{n}.html"
  end

  desc "Create a post from blade (params: N=43004)"
  task :import => :environment do
    raise "N not given" unless ENV["N"]

    n = ENV["N"].to_i
    if post = Blade.new(n).post
      existing = Post.find_by_number(n)
      if post.save
        puts "saved: #{post} (number: #{post.number}, id: #{post.id})"
        if existing
          puts "existing: #{existing} (number: #{existing.number}, id: #{existing.id})"
          existing.destroy
        end
      else
        puts "error: failed to save: #{post.to_yaml}"
      end
    end
  end

  desc "Create a post from blade (params: DIR=misc/files)"
  task :load => :environment do
    dir = File.expand_path(ENV["DIR"] || "misc/files/")
    Dir["#{dir}/*"].select{|path|
      File.basename(path) =~ /\A\d+\z/
    }.sort.each{|path|
      n = File.basename(path).to_i

      if Post.find_by_number(n)
        puts "skipping #{n}"
        next
      end

      html = File.read(path, encoding: "binary").
        encode("utf-8", "euc-jp", invalid: :replace, undef: :replace)
      saved = Blade.new(n, html).create
      if saved
        puts "saved post from #{path}"
      else
        raise "failed to load #{path}"
      end
    }
  end
end
