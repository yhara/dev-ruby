class Translation < ActiveRecord::Base
  belongs_to :post
  
  # validations
  validates_presence_of :post_id, :body
end
