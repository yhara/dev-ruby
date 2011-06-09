class User < ActiveRecord::Base
  # Associations
  has_many :accounts
  has_many :translations
  has_many :translation_requests
  has_many :posts, :through => :translation_requests
  alias requesting_posts posts

  attr_protected :name
  
  # Plugins
  has_friendly_id :name

  # prohibit MetaSearch to search using user information
  attr_unsearchable *self.column_names
  assoc_unsearchable :accounts, :translations, :translation_requests, :posts

  # Validations
  validates_presence_of :name, :timezone
  validates_uniqueness_of :name

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
