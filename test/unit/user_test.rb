require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "with valid attrs" do
    should "create a user via omniauth" do
      assert User.new(name: "foo").valid?
    end
  end

end
