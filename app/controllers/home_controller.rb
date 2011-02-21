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

  def about
  end

  def rss
    type = params[:view]
    if type.blank?
      # render rss.html.slim
    else
      render :xml => make_rss(RSSFeed.new(type, 100).events)
    end
  rescue RSSFeed::UnknownType
    not_found
  end

  def make_rss(items)
    RSS::Maker.make("2.0"){|feed|
      feed.channel.title = "ruby-dev translation"
      feed.channel.link = "http://ruby-dev.route477.net/"
      feed.channel.description = "Community translation of ruby-dev"
      #feed.items.do_sort = true

      items.each do |item|
        entry = feed.items.new_item
        entry.title = case item
                      when Post 
                        "new post: #{item.subject}"
                      when TranslationRequest
                        "requested: #{item.post.topic.subject}"
                      when Translation
                        "translated: #{item.post.topic.subject}"
                      end
        entry.link = case item
                     when Post 
                       url_for
                       post_url(item)
                     when Translation
                       post_url(item.post)
                     when TranslationRequest
                       post_url(item.post)
                     end
                       
        entry.date = item.created_at.to_s
        entry.description = case item
                            when Post 
                              item.body
                            when Translation
                              item.body
                            when TranslationRequest
                              item.post.body
                            end
      end
    }.to_s
  end

end
