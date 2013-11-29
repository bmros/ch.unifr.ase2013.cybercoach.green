class ApisController < ApplicationController
  #include ActionController::Cookies
  include SessionsHelper
  require 'nokogiri'
  require 'open-uri'
  require 'active_support/core_ext/hash/conversions.rb'



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

    doc = Nokogiri::XML(@response)
    events = doc.search('session_key').text

    @response = events
    #sign_in_fatsecret(@response)

    #TODO: create cookie only if events = session_key

    #cookies.permanent.signed[:fatsecret_session_key] = [@response]
    cookies[:fatsecret_session_key] = { :value => @response, :expires => Time.now + 3600}
    self.current_fatsecret_session_key = @response
    redirect_to :back
    #redirect_to /user_links/

  end
end
