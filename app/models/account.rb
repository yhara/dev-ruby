class Account < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :provider, :uid, :name, :user_id
end
