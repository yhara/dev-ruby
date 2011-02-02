class TranslationRequestsController < ApplicationController
  before_filter :find_post
  before_filter :require_login, :only => [:create, :destroy]

  def create
    req = TranslationRequest.new(user: current_user,
                                 post: @post)
    @success = req.save
    @created = true
    render "toggle_star.js.erb"
  end

  def destroy
    req = TranslationRequest.where(
      user_id: current_user.id,
      post_id: @post.id
    ).first

    if req
      req.destroy
      @success = true
      @created = false
      render "toggle_star.js.erb"
    else
      not_found
    end
  end
end
