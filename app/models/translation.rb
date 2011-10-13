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

  def diff_from(other)
    a, b = self, other

    diff = Diff::LCS.sdiff(a.body.lines.to_a,
                           b.body.lines.to_a)

    [diff.map{|item| [item.action, item.old_element]},
     diff.map{|item| [item.action, item.new_element]}]
  end
end
