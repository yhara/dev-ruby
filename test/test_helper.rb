
require 'simplecov'
SimpleCov.start 'rails'

require 'spork'

Spork.prefork do
end

Spork.each_run do
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'fakeweb'
FakeWeb.allow_net_connect = false

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end

# For debugging

class Post; def inspect; "#<Post #{self.number}>"; end; end

module Enumerable
  def each_p
    puts "[each_p]"
    each{|x| print "  "; p x}
    puts "[/each_p]"
  end
end
