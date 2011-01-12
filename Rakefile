# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

DevRuby::Application.load_tasks

task "heroku:set" do
  sh "heroku config:add TWITTER_KEY=a7hnMNpcSnTfqMZ1B835A"
  sh "heroku config:add TWITTER_SECRET=g6P6OVh0y3iUhekfpQaV7u3VqREysKE8c6VMXZ4c9Y"
end
