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

  cattr_reader :per_page # will_paginate
  @@per_page = 100

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

  # Methods
  def translation
    if (trs = self.translations)
      trs.max_by{|tr| tr.created_at}
    end
  end
  alias last_translation translation
  alias translated? translation

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
end
