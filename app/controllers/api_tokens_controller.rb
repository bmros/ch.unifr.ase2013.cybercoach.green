class ApiTokensController < ApplicationController
  #before_filter :authenticate_user!
  def create
    auth = omniauth(request.env['omniauth.auth'])
    user_id = request.env['omniauth.params']['user_id']
    origin = request.env['omniauth.origin']

    @userlink = UserLink.find(user_id)

    @new_api = @userlink.api_tokens.build(auth)

    if @new_api.save
      redirect_to origin
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
