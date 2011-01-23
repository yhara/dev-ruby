class TranslationRequestsController < ApplicationController
  before_filter :find_post

  def index
    @users = @post.requesting_users
    respond_with @users
  end

  def create
  end

  def destroy
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

end
