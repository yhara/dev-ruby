require 'test_helper'

class TranslationsControllerTest < ActionController::TestCase
  setup do
    @translation = translations(:one)
    @post = @translation.post
  end

  context "logged in user" do
    should "get :new" do
      login_as users(:one)
      get :new, :post_id => @post.number.to_s
      assert_response :success
    end

    should "post :create" do
      login_as users(:one)
      assert_difference('Translation.count') do
        post :create, :post_id => @post.number.to_s,
                      :translation => @translation.attributes
      end

      assert_redirected_to post_path(assigns(:translation).post)
    end
  end

  context "guest user" do
    setup do
      logout
    end

    should "not get :new" do
      get :new, :post_id => @post.number.to_s
      assert_not_nil flash[:error]
    end

    should "not post :create" do
      assert_no_difference('Translation.count') do
        post :create, :post_id => @post.number.to_s,
                      :translation => @translation.attributes
      end
      assert_not_nil flash[:error]
    end
  end

  context "any user" do
    should "get :index" do
      translation = Fabricate(:translation, :body => "hello")

      get :index, :post_id => translation.post.number.to_s

      assert_match /hello/, @response.body
    end
  end

end
