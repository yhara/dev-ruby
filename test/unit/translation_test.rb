require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  context "with valid attributes given" do
    should "create an instance" do
      attrs = {
        post_id: posts(:one).id,
        user_id: users(:one).id,
        body: "world"
      }
      assert_equal true, Translation.new(attrs).valid?
    end
  end

  context "when invalid attributes are given" do
    should "check post_id" do
      attrs = {
        post_id: nil,
        user_id: users(:one).id,
        body: ""
      }
      assert_equal false, Translation.new(attrs).valid?
    end

    should "check user_id" do
      attrs = {
        post_id: posts(:one).id,
        user_id: nil,
        body: ""
      }
      assert_equal false, Translation.new(attrs).valid?
    end

    should "check body" do
      attrs = {
        post_id: posts(:one).id,
        user_id: users(:one).id,
        body: ""
      }
      assert_equal false, Translation.new(attrs).valid?
    end
  end
end
