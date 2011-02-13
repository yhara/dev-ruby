require 'twitter'

class UsersController < ApplicationController

  def new
    @user = User.new
    @account = Account.find(session[:account_id])
    @profile_image = profile_image_url
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def create
    @account = Account.find(session[:account_id])
    @user = User.new(params[:user])
    @user.name = @account.name

    if @user.save
      @account.user = @user
      @account.save
      login_as @user
      redirect_to root_path
    else
      @profile_image = profile_image_url
      render action: "new"
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def profile_image_url
    Twitter.profile_image(@account.name)
  end

end
