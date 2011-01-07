require 'blade.rb'

namespace :blade do
  desc "Download blade html to test/data usage: rake blade:get N=42897"
  task :get => :environment do
    raise "N not given" unless ENV["N"]

    n = ENV["N"].to_i
    sh "curl http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/#{n} -o test/data/#{n}.html"
  end
end
