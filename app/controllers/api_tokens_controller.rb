class ApiTokensController < ApplicationController
  include SessionsHelper
  #before_filter :authenticate_user!
  def create
    auth = omniauth(request.env['omniauth.auth'])
    user_id = request.env['omniauth.params']['user_id']
    origin = request.env['omniauth.origin']

    @user_link = UserLink.find(user_id)

    @new_api = @user_link.api_tokens.build(auth)

    if @new_api.save
      sessionkeygetparams
      redirect_to user_path(session[:current_user_link_username])
    end
  end

  private

  def omniauth auth
    params = {
        "provider" => auth['provider'],
        "auth_token" => auth['credentials']['token'],
        "auth_secret" => auth['credentials']['secret']
    }
  end
end
