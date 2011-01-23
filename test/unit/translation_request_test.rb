require 'test_helper'

class TranslationRequestTest < ActiveSupport::TestCase
  test "validation" do
    assert_equal true, TranslationRequest.new(user: users(:one),
                                     post: posts(:two)).valid?
    assert_equal false, TranslationRequest.new(user: users(:one)).valid?
    assert_equal false, TranslationRequest.new(translation_requests(:one).attributes).valid?
  end

  test "associations" do
    assert users(:one).requesting_posts.include?(posts(:one))
    assert posts(:one).requesting_users.include?(users(:one))
  end
end
