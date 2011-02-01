class Translation < ActiveRecord::Base
  belongs_to :post
  
  # validations
  validates :post_id, presence: true
  validates_presence_of :subject, unless: "subject.nil?"
  validates_presence_of :body, if: "subject.nil?"
end
