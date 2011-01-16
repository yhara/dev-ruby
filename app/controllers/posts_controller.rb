class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.roots.order("number DESC").limit(100).map{|root| root.subtree.arrange}
    #arrange #order("number DESC").limit(40).arrange(:order => :time)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    if @post.is_root?
      @root = @post
      @posts = [@root] + @root.descendants.includes(:translations)

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @post }
      end
    else
      redirect_to :action => :show, :id => @post.root.number, :anchor => @post.number
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
