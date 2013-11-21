class SessionsController < ApplicationController
  include SessionsHelper 

  def new
    @titre = "Login"
  end
  
  def create
    userlink = UserLink.authenticate(params[:session][:username],
                             params[:session][:password])
    if userlink.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in userlink
	  redirect_to userlink
	  session[:current_userlink_id] = userlink.id
    end
  end
  
  def destroy
  	session[:current_userlink_id] = nil
    sign_out
    redirect_to root_path
  end  
  
  
end