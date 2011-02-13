class Account < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :provider, :uid, :name

  def self.new_with_omniauth(auth)
    Account.new(provider: auth["provider"],
                uid: auth["uid"],
                name: auth["user_info"]["name"])
  end
end
