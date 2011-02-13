require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  context "when signing up" do
    should "post create (callback)" do
      @request.env["omniauth.auth"] = {
        "provider" => "twitter",
        "uid" => "12345678",
        "user_info" => {"name" => "aaaa"}
      }

      assert_difference "Account.count" do
        post :create
      end

      assert_redirected_to new_user_path
      assert_equal Account.last.id, session["account_id"]
    end
  end

  context "when signing in" do
    should "post create" do
      user = users(:one)
      account = user.accounts.first

      @request.env["omniauth.auth"] = {
        "provider" => account.provider,
        "uid" => account.uid,
        "user_info" => {"name" => account.name}
      }
      assert_no_difference "Account.count" do
        post :create
      end

      assert_redirected_to root_path
      assert_equal session["user_id"], user.id
    end
  end
end
