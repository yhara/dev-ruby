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
    if req.save
      render :json => {ok: true}
    else
      render :json => {error: true}
    end
  end

  def destroy
    if (req = TranslationRequest.where(user_id:current_user.id, post_id:@post.id).first)
      req.destroy
      render :json => {ok: true}
    else
      not_found
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

end
