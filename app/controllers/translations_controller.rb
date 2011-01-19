class TranslationsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @translations = @post.translations.order("created_at DESC")

  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  def new
    @post = Post.find(params[:post_id])
    @translation = Translation.new

    @last_subject = @post.translation.try(:subject) || @post.subject
    @last_body = @post.translation.try(:body) || @post.body
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  def create
    @translation = Translation.new(params[:translation])
    @translation.post = Post.find(params[:post_id])

    if @translation.save
      redirect_to(@translation.post, :notice => 'Translation was successfully created.')
    else
      render :action => "new"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end
end
