class UsersController < ApplicationController

  def new
    @user = User.new
    @account = Account.find(session[:account_id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def create
    @user = User.new(params[:user])
    @account = Account.find(session[:account_id])

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
