class MailsController < ApplicationController
  # GET /mails
  # GET /mails.xml
  def index
    @mails = Mail.roots.order("number DESC").limit(100).map{|root| root.subtree.arrange}
    #arrange #order("number DESC").limit(40).arrange(:order => :time)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mails }
    end
  end

  # GET /mails/1
  # GET /mails/1.xml
  def show
    @mail = Mail.find(params[:id])
    if @mail.is_root?
      @root = @mail
      @mails = [@root] + @root.descendants.includes(:translations)

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @mail }
      end
    else
      redirect_to :action => :show, :id => @mail.root.number, :anchor => @mail.number
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  # GET /mails/new
  # GET /mails/new.xml
  def new
    @mail = Mail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mail }
    end
  end

  # POST /mails
  # POST /mails.xml
  def create
    @mail = Mail.new(params[:mail])

    respond_to do |format|
      if @mail.save
        format.html { redirect_to(@mail, :notice => 'Mail was successfully created.') }
        format.xml  { render :xml => @mail, :status => :created, :location => @mail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mail.errors, :status => :unprocessable_entity }
      end
    end
  end
end
