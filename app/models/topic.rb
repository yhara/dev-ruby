class Topic < ActiveRecord::Base
  belongs_to :root, class_name: "Post", foreign_key: "post_id"
  
  validates_presence_of :post_id, :subject, :last_update
end
