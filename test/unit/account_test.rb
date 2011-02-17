require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  context "with valid attrs" do
    should "create an account via omniauth" do
      auth = {
        "provider" =>  "twitter",
        "uid" =>  "12345",
        "user_info" => {"nickname" => "asdf"}
      }
      account = Account.new_with_omniauth(auth)
      assert_difference "Account.count" do
        account.save
      end

      assert_equal "twitter", account.provider
      assert_equal "12345", account.uid
      assert_equal "asdf", account.name
    end
  end

  context "with errornous attrs" do
    should "not create an user nor an account" do
      assert_equal false,
        Account.new_with_omniauth({"user_info" => {}}).valid?
    end
  end

end
