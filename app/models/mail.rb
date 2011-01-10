class Mail < ActiveRecord::Base
  has_ancestry

  def to_title
    "<h2>[ruby-dev:#{self.number}] #{self.subject}</h2>".
      sub(/\[.*?\]/){|match| "#{match}<br>"}
  end
end
