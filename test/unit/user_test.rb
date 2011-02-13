require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "with valid attrs" do
    should "create a user" do
      assert User.new(name: "foo", timezone: "Tokyo").valid?
    end
  end

  context "with invalid attrs" do
    should "not create a user" do
      assert_equal false, User.new(name: "foo", timezone: "aaaa").valid?
    end
  end

end
