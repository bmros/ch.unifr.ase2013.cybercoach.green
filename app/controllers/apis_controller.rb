class ApisController < ApplicationController
  def fatsecret
    tokens = {}
    unless params[:user_link_id].nil?
      user = UserLink.find(params[:user_link_id])
      tokens = user.api_tokens.find_by_provider('fatsecret')
    end
    request = Fatsecret::Api.new({}).api_call(
        #ENV['FATSECRET_KEY'],
        #ENV['FATSECRET_SECRET'],
        'cac271e1f5114c8298cd23ca772809fd',
        'c6172e6faf1b49bb8d66b674e7a18846',
        params,
        tokens['auth_token'] ||= "",
        tokens['auth_secret'] ||= ""
    )
    @response = request.body
  end
end
