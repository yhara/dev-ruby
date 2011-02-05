class User < ActiveRecord::Base
  #has_many :translations
  
  has_many :translation_requests
  has_many :posts, :through => :translation_requests
  alias requesting_posts posts
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end  
  end  

  def requesting?(post)
    post.translation_requests.any?{|req| req.user_id == self.id}
  end
end
