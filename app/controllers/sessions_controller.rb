class SessionsController < ApplicationController
  include SessionsHelper

=begin
  def new
    @titre = "Login"
  end
=end


  def create
    user_link = UserLink.authenticate(params[:session][:username], params[:session][:password])

   # redirect_to fatsecret_auth_path(user_link.id,true) and return


   # session_key =

    if user_link.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in user_link
      redirect_to user_link
	  #redirect_to myexercise_path(user_link.id)
      session[:current_user_link_id] = user_link.id
      session[:current_user_link_username] = user_link.username
      session[:current_user_link_password] = params[:session][:password] #not crypted!
    end
  end

  def destroy
    session[:current_user_link_id] = nil
    session[:current_user_link_password] = nil
    session[:current_user_link_username] = nil
    sign_out
    redirect_to root_path
  end


end