class TranslationsController < ApplicationController

  # GET /translations/new
  def new
    @post = Post.find(params[:post_id])
    @translation = Translation.new

    @last_subject = @post.translation.try(:subject) || @post.subject
    @last_body = @post.translation.try(:body) || @post.body

    respond_to do |format|
      format.html # new.html.erb
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  # POST /translations
  def create
    @translation = Translation.new(params[:translation])
    @translation.post = Post.find(params[:post_id])

    respond_to do |format|
      if @translation.save
        format.html { redirect_to(@translation.post, :notice => 'Translation was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end
end
