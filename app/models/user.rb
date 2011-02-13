class User < ActiveRecord::Base
  has_many :accounts
  has_many :translations
  has_many :translation_requests
  has_many :posts, :through => :translation_requests
  alias requesting_posts posts

  validates_presence_of :name

  def activity
    @activity ||= Activity.new(self)
  end

  def requesting?(post)
    post.translation_requests.any?{|req| req.user_id == self.id}
  end
end
