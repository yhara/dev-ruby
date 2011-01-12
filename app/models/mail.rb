class Mail < ActiveRecord::Base
  has_ancestry
  has_friendly_id :number
  has_many :translations

  def to_title
    "<h2>[ruby-dev:#{self.number}] #{self.subject}</h2>".
      sub(/\[.*?\]/){|match| "#{match}<br>"}
  end

  def translation
    if (trs = self.translations)
      trs.max_by{|tr| tr.created_at}
    end
  end
end
