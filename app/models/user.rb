class User < ActiveRecord::Base
  has_many :accounts
  has_many :translations
  has_many :translation_requests
  has_many :posts, :through => :translation_requests
  alias requesting_posts posts

  validates_presence_of :name
  
  def self.create_with_omniauth(auth)  
    name = auth["user_info"]["name"]  
    user = User.create(name: name)
    if user
      account = Account.create(provider: auth["provider"],
                               uid: auth["uid"],
                               name: auth["user_info"]["name"],
                               user_id: user.id)
      if account
        user
      else
        nil
      end
    else
      nil
    end
  end  

  def activity
    @activity ||= Activity.new(self)
  end

  def requesting?(post)
    post.translation_requests.any?{|req| req.user_id == self.id}
  end
end
