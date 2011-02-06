class Translation < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  # validations
  validates_presence_of :post_id, :user_id, :body
end
