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

  # will_paginate
  cattr_reader :per_page
  @@per_page = 100

  def to_title
    "<h2>[ruby-dev:#{self.number}] #{self.subject}</h2>"
  end

  def translation
    if (trs = self.translations)
      trs.max_by{|tr| tr.created_at}
    end
  end

  def translation_subject
    translation.try(:subject) || self.subject
  end

  def translation_body
    translation.try(:body) or self.body
  end

  def css_class
    if self.translation 
      "translated" 
    else
      "not_translated"
    end
  end
end
