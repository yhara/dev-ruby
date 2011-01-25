require 'test_helper'

class TranslationRequestsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  context "logged in user" do
    should "get index" do
      login_as users(:one)
      get :index, :post_id => @post.number.to_s
      assert_response :success
    end

    should "get create" do
      login_as users(:two)
      assert_difference "TranslationRequest.count", 1 do
        get :create, :post_id => @post.number.to_s
        assert_response :success
      end
    end

    should "get destroy" do
      login_as users(:one)
      assert_difference "TranslationRequest.count", -1 do
        get :destroy, :post_id => @post.number.to_s
        assert_response :success
      end
    end
  end

  context "guest user" do
    should "get index" do
      logout
      get :index, :post_id => @post.number.to_s
      assert_response :success
    end

    should "not get create" do
      logout
      assert_no_difference "TranslationRequest.count" do
        get :create, :post_id => @post.number.to_s
      end
    end

    should "not get destroy" do
      logout
      assert_no_difference "TranslationRequest.count" do
        get :destroy, :post_id => @post.number.to_s
      end
    end
  end
end
