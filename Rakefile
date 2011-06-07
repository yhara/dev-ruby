# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

DevRuby::Application.load_tasks

desc "install pg gem"
task "install_pg_gem" do
  sh "gem i pg -- --with-pg-config=/opt/local/lib/postgresql83/bin/pg_config"
end

desc "start postgres"
task "start_postgres" do
  sh "postgres -D /usr/local/var/postgres"
end
