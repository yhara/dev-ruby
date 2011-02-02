class Post < ActiveRecord::Base
  has_many :translations

  has_many :translation_requests
  has_many :users, :through => :translation_requests

  has_one :topic

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
