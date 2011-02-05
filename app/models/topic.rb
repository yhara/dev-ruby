class Topic < ActiveRecord::Base
  belongs_to :root, class_name: "Post", foreign_key: "post_id"
  
  validates_presence_of :post_id, :subject, :last_update

  attr_accessible :subject

  def needs_subject_translation?
    not self.subject.ascii_only?
  end

end
