require 'twitter'

class UsersController < ApplicationController

  def new
    @user = User.new
    @account = Account.find(session[:account_id])
    @profile_image = session[:profile_image]
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def create
    @account = Account.find(session[:account_id])
    @user = User.new(params[:user])
    @user.name = @account.name
    @profile_image = @user.profile_image_url = session[:profile_image]

    if @user.save
      @account.user = @user
      @account.save
      login_as @user
      redirect_to root_path
    else
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

end
