require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  should "sign up" do
    @request.env["omniauth.auth"] = {
      "provider" => "twitter",
      "uid" => "12345678",
      "user_info" => {"name" => "aaaa"}
    }

    assert_difference "User.count" do
      get :create
    end

    assert_redirected_to root_path
    assert_equal session["user_id"], User.order("created_at DESC").first.id
  end

  should "sign in" do
    user = users(:one)
    account = user.accounts.first

    @request.env["omniauth.auth"] = {
      "provider" => account.provider,
      "uid" => account.uid,
      "user_info" => {"name" => account.name}
    }
    assert_no_difference "User.count" do
      get :create
    end

    assert_redirected_to root_path
    assert_equal session["user_id"], user.id
  end
end
