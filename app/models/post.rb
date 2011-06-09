class Post < ActiveRecord::Base
  # Associations
  has_many :translations

  has_many :translation_requests
  has_many :users, :through => :translation_requests

  has_one :topic

  # Note: you may think 'alias requesting_users users' is better, but
  # it spoils eager loading (see also: posts#index)
  def requesting_users
    self.translation_requests.map &:user
  end

  # Plugins
  has_friendly_id :number

  has_ancestry
  alias root? is_root?

  # Validations
  validates :number, presence: true, uniqueness: true
  validates :subject, presence: true
  validates :from, presence: true
  validates :time, presence: true
  validates :body, presence: true

  # Callbacks
  
  after_save :update_topic

  def update_topic
    if self.root?
      topic = Topic.new
      topic.post_id = self.id
      topic.subject = self.subject
      topic.last_update = self.time

      raise "failed to create topic" unless topic.save
    else
      topic = Topic.find_by_post_id(self.root.id)
      if topic.last_update < self.time
        topic.last_update = self.time
        topic.save
      else
        puts "warning: this mail (#{self.inspect}) is older than last_update" 
      end
    end
  end

  # scopes
  
  scope :no_duplicates, lambda {
    group(column_names.map{|name| "#{table_name}.#{name}" }.join(', '))
  }
  
  scope :translated, lambda{
    joins(:translations).
    no_duplicates
  }

  scope :not_translated, lambda{
    where('(SELECT COUNT(*) FROM translations WHERE post_id = posts.id) = 0')
  }

  scope :has_request, lambda{
    joins(:translation_requests).
    no_duplicates
  }

  scope :recent_requested, lambda{
    has_request.
    order('(SELECT MAX(created_at) FROM "translation_requests"
            WHERE post_id = posts.id) DESC').
    includes(:translations, {translation_requests: :user})
  }

  scope :top_requested, lambda{
    has_request.
    not_translated.
    order('(SELECT COUNT(*) FROM "translation_requests"
            WHERE post_id = posts.id) DESC').
    includes(:translations, {translation_requests: :user})
  }

  scope :recent_translated, lambda{
    translated.
    order('(SELECT MAX(created_at) FROM "translations"
            WHERE post_id = posts.id) DESC').
    includes(:translations, {translation_requests: :user})
  }

  # Instance methods

  def created_at
    self.time
  end

  def to_s
    self.number.to_s
  end

  def translation
    if (trs = self.translations)
      trs.max_by{|tr| tr.created_at}
    end
  end
  alias last_translation translation
  alias translated? translation

  def topic_subject
    self.root.topic.subject
  end

  def translated_body
    translation ? translation.body : body
  end

  def css_class
    if self.translated? 
      "translated" 
    else
      "not_translated"
    end
  end

  REXP_FROM = /(.*) <(.*)>/
  def from_name
    self.from[REXP_FROM, 1]
  end

  def from_address
    self.from[REXP_FROM, 2]
  end
end
