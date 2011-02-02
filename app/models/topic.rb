class Topic < ActiveRecord::Base
  belongs_to :root, class_name: "Post"
  
  validates_presence_of :post_id, :subject, :last_update
end
