class Translation < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  # validations
  validates_presence_of :post_id, :user_id, :body

  def revision
    Translation.where(post_id: self.post_id).
      order(:created_at).
      to_a.index(self) + 1
  end
end
