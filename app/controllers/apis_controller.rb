class ApisController < ApplicationController
  def fatsecret
    tokens = {}
    unless params[:user_id].nil?
      user = User.find(params[:user_id])
      tokens = user.api_tokens.find_by_provider('fatsecret')
    end
    request = Fatsecret::Api.new({}).api_call(
        ENV['FATSECRET_KEY'],
        ENV['FATSECRET_SECRET'],
        params,
        tokens['auth_token'] ||= "",
        tokens['auth_secret'] ||= ""
    )
    @response = request.body
  end
end

