class SessionsController < ApplicationController
  include SessionsHelper 

=begin
  def new
    @titre = "Login"
  end
=end

  
  def create
    userlink = UserLink.authenticate(params[:session][:username], params[:session][:password])
    if userlink.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in userlink
	  redirect_to userlink
	  session[:current_userlink_id] = userlink.id
	  session[:current_userlink_username] = userlink.username
	  session[:current_userlink_password] = params[:session][:password] #not crypted!
    end
  end
  
  def destroy
  	session[:current_userlink_id] = nil
	session[:current_userlink_password] = nil
	session[:current_userlink_username] = nil
    sign_out
    redirect_to root_path
  end  
  
  
end