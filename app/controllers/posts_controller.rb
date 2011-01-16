class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.roots.order("number DESC").limit(100).map{|root| root.subtree.arrange}
    #arrange #order("number DESC").limit(40).arrange(:order => :time)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    if @post.is_root?
      @root = @post
      @posts = [@root] + @root.descendants.includes(:translations)

      respond_to do |format|
        format.html # show.html.erb
      end
    else
      redirect_to :action => :show, :id => @post.root.number, :anchor => @post.number
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
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
