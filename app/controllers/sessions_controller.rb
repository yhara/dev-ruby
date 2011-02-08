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
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
    session[:user_id] = user.id  

    path = path_of(session[:login_required_path])

    redirect_to path, :notice => "Signed in!" 
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
