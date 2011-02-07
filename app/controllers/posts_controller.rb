require 'blade.rb'

class PostsController < ApplicationController
  before_filter :find_post, :only => [:show]

  # GET /posts
  def index
    case params[:view]
    when "recent_requested"
      @posts = Post.recent_requested.paginate(page: params[:page],
                                              per_page: 20)
      @title = "Recently requested"
    when "top_requested"
      @posts = Post.top_requested.paginate(page: params[:page],
                                           per_page: 20)
      @title = "Top requested"
    when "recent_translated"
      @posts = Post.recent_translated.paginate(page: params[:page],
                                               per_page: 20)
      @title = "Recent translated"
    else
      @title = "Recent posts"
      @topics = Topic.includes(:root).
        paginate(page: params[:page],
                 per_page: 25,
                 order: "last_update DESC")
      @posts = @topics.map{|topic|
          tree = topic.root.subtree.includes(:translations, {translation_requests: :user}).arrange
          [tree.keys.first, tree]
      }
    end
  end

  # GET /posts/1
  def show
    if @post.root?
      @root = @post
      @posts = [@root] + @root.descendants.includes(:translations)

      respond_to do |format|
        format.html # show.html.erb
      end
    else
      redirect_to :action => :show, :id => @post.root.number, :anchor => @post.number
    end
  end

  # GET /posts/new
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
