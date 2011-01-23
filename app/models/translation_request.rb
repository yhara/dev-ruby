class TranslationRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_presence_of :user_id, :post_id
  validates_uniqueness_of :post_id, scope: :user_id
end
