require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "with valid attrs" do
    should "create a user" do
      u = User.new(timezone: "Tokyo")
      u.name = "foo"
      assert u.valid?
    end
  end

  context "with invalid attrs" do
    should "not create a user" do
      u = User.new(timezone: "----")
      u.name = "foo"
      assert !u.valid?

      u = User.new(timezone: "Tokyo")
      u.name = users(:one).name
      assert !u.valid?
    end
  end

end
