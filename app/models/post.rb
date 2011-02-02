class Post < ActiveRecord::Base
  has_many :translations

  has_many :translation_requests
  has_many :users, :through => :translation_requests

  # Note: you may think 'alias requesting_users users' is better, but
  # it spoils eager loading (see also: posts#index)
  def requesting_users
    self.translation_requests.map &:user
  end

  has_friendly_id :number

  has_ancestry
  alias root? is_root?

  # will_paginate
  cattr_reader :per_page
  @@per_page = 100

  # validations
  validates :number, presence: true
  validates :subject, presence: true
  validates :from, presence: true
  validates :time, presence: true
  validates :body, presence: true

  def translation
    if (trs = self.translations)
      trs.max_by{|tr| tr.created_at}
    end
  end
  alias last_translation translation

  def translation_subject
    last_translation.try(:subject) || self.subject
  end

  def translation_body
    last_translation.try(:body) or self.body
  end

  def body_translated?
    last_translation.try(:body)
  end

  def needs_subject_translation?
    self.root? and
    (not self.subject.ascii_only?) and
      translations.empty?
  end

  def css_class
    if self.body_translated? 
      "translated" 
    else
      "not_translated"
    end
  end
end
