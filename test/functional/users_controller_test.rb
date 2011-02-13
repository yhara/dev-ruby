require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "when has no account" do
    should "not view new or create directly" do
      get :new
      assert_response 404
      get :create
      assert_response 404
    end

    should "get new via sessions#create" do
      account = Fabricate(:account)
      session[:account_id] = account.id

      get :new
      assert_response :success
    end

    should "post create" do
      account = Fabricate(:account)
      session[:account_id] = account.id

      assert_difference "User.count" do
        post :create, user: {name: "xxx"}
        assert_redirected_to root_path
      end

      user = assigns[:user]
      assert_equal "xxx", user.name
      assert_equal account, user.accounts.first
    end
  end

end
