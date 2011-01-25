class TranslationRequestsController < ApplicationController
  before_filter :find_post
  before_filter :require_login, :only => [:create, :destroy]

  respond_to :html, :json

  def index
    @users = @post.requesting_users
    respond_with @users
  end

  def create
    req = TranslationRequest.new(user: current_user,
                                 post: @post)
    req.save
    respond_with req
  end

  def destroy
    req = TranslationRequest.where(user_id:current_user.id, post_id:@post.id).first
    if req
      req.destroy
    else
      redirect_to "/404.html"
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

end
