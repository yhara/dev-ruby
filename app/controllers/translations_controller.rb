class TranslationsController < ApplicationController
  before_filter :find_post, :only => [:index, :new, :create]
  before_filter :require_login, :only => [:new, :create]

  def index
    @translations = @post.translations.order("created_at DESC")
  end

  def new
    @translation = Translation.new

    @last_subject = @post.translation.try(:subject) || @post.subject
    @last_body = @post.translation.try(:body) || @post.body
  end

  def create
    @translation = Translation.new(params[:translation])
    @translation.post = @post
    # Clear subject if it is not the first post of the thread
    @translation.subject = nil if not @post.root?

    if @translation.save
      redirect_to(@translation.post, :notice => 'Translation was successfully created.')
    else
      render :action => "new"
    end
  end
end
