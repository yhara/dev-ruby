class HomeController < ApplicationController
  before_filter :require_login, :only => [:activities]

  def index
      @title = "Recent posts"
      @topics = Topic.includes(:root).
        order("last_update DESC").limit(15)
      @posts = @topics.map{|topic|
          tree = topic.root.subtree.includes(:translations, {translation_requests: :user}).arrange
          [tree.keys.first, tree]
      }
  end

  def activities
    @events = current_user.activity.events(10)
  end

end
