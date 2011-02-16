class User < ActiveRecord::Base
  has_many :accounts
  has_many :translations
  has_many :translation_requests
  has_many :posts, :through => :translation_requests
  alias requesting_posts posts

  attr_protected :name

  validates_presence_of :name, :timezone

  validates_each :timezone do |user, attr, timezone|
    unless ActiveSupport::TimeZone[timezone]
      user.errors.add(:timeone, "Unknown timezone name")
    end
  end

  def activity
    @activity ||= Activity.new(self)
  end

  def requesting?(post)
    post.translation_requests.any?{|req| req.user_id == self.id}
  end
end
