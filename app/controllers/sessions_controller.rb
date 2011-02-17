class SessionsController < ApplicationController
  def login_required
    if signed_in?
      redirect_to path_of(params[:path])
    else
      session[:login_required_path] = params[:path]
    end
  end

  def create  
    auth = request.env["omniauth.auth"]  
    account = Account.find_by_provider_and_uid(auth["provider"],
                                               auth["uid"])
    if account and account.user
      path = path_of(session[:login_required_path] || root_path)
      login_as account.user
      redirect_to path, :notice => "Signed in!" 
    else
      if account || (account = Account.new_with_omniauth(auth)).save
        session[:account_id] = account.id
        redirect_to new_user_path
      else
        render text: "failed to create an account"
      end
    end
  end  

  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"  
  end 

  def debug_login
    name = params[:name]
    session[:user_id] = User.find_by_name(name).id
    redirect_to root_url, :notice => "Signed in!" 
  end

  private
  def path_of(path)
    begin
      uri = URI.parse(session[:login_required_path])
      path = uri.path # + ("##{uri.fragment}" if uri.fragment).to_s
    rescue URI::InvalidURIError
      path = nil
    end

    if path.blank? then root_path else path end
  end
end
