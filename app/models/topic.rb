class Topic < ActiveRecord::Base
  belongs_to :root, class_name: "Post", foreign_key: "post_id"
  
  validates_presence_of :post_id, :subject, :last_update

  attr_accessible :subject

  def needs_subject_translation?
    not self.subject.ascii_only?
  end

  def merge_to(post)
    raise ArgumentError unless post.is_a?(Post)

    other_topic = post.root.topic

    self.root.parent = post
    self.root.save!

    if self.last_update > other_topic.last_update
      other_topic.last_update = self.last_update
      other_topic.save!
    end

    self.destroy
  end
end
