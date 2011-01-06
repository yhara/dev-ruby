require 'blade.rb'

desc "Update mails from blade ruby-dev archive"
task :cron => :environment do
  Blade.update
end
