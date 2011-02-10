require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "with valid attrs" do
    should "create a user via omniauth" do
      auth = {
        "provider" =>  "twitter",
        "uid" =>  "12345",
        "user_info" => {"name" => "asdf"}
      }
      user = nil
      assert_difference "Account.count" do
        assert_difference "User.count" do
          user = User.create_with_omniauth(auth)
        end
      end

      account = user.accounts.first
      assert_equal "twitter", account.provider
      assert_equal "12345", account.uid
      assert_equal "asdf", account.name
      assert_equal "asdf", user.name
    end
  end

  context "with errornous attrs" do
    should "not create an user nor an account" do
      assert_no_difference "Account.count" do
        assert_no_difference "User.count" do
          user = User.create_with_omniauth({"user_info" => {}})
        end
      end
    end
  end

end
