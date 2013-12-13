module SessionsHelper
  require 'nokogiri'
  require 'open-uri'
  require 'active_support/core_ext/hash/conversions.rb'



  def sign_in(userlink)
    cookies.permanent.signed[:remember_token] = [userlink.id, userlink.salt]
    self.current_userlink = userlink
  end

  def sign_in_fatsecret(params)
    sessionkey(params)
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_userlink = nil
  end

  def sign_out_fatsecret
    cookies.delete(:fatsecret_session_key)
  end

  def current_userlink=(userlink)
    @current_userlink = userlink
  end

  def current_userlink
    @current_userlink ||= userlink_from_remember_token
  end

  def current_fatsecret_session_key=(fatsecret)
    @ccurrent_fatsecret_session_key = fatsecret
  end

  def current_fatsecret_session_key
    @current_fatsecret_session_key ||= fatsecret_session_key_from_remember_token
  end



  def signed_in?
    !current_userlink.nil?
  end

  def sessionkeygetparams

    #p = params
    #p[:method] = 'profile.request_script_session_key'
    #p[:cookie] = 'true'

    params3 = params.except();
    #params3[:utf8] = "✓"
    params3[:action] = "create"
    params3[:controller] = "sessions"
    params3[:user_id] = session[:current_user_link_id]

    #{"utf8"=>"✓", "action"=>"create", "controller"=>"sessions", "user_id"=>6, "method"=>"exercise_entries.get"}
    # params.merge(:method => 'profile.request_script_session_key')
    # params.merge(:cookie => 'true')

     debug = params3
     session[:debug] = debug


     sessionkey(params3)
  end


  def exercisesgetparams
     params

  end




  def sessionkey(params)



    tokens = {}
    # unless params[:user_link_id].nil?
    unless session[:current_user_link_id].nil?

      #user = UserLink.find(params[:user_link_id])
      #user = session[:current_user_link_id]
      user = UserLink.find(session[:current_user_link_id])
      tokens = user.api_tokens.find_by_provider('fatsecret')
    end

    params.merge(:user_id => session[:current_user_link_id])

    params2 = params.except(:authenticity_token, :session, :password, :submit)
    params2 = params2.merge(:user_id => session[:current_user_link_id])
    params2 = params2.merge(:method => 'profile.request_script_session_key')
    params2 = params2.merge(:cookie => 'true')


    #<%= hidden_field_tag 'method', 'profile.request_script_session_key' %>
    #    <%= hidden_field_tag 'cookie', 'true' %>


    #params2.raise.inspect

    # render :text => params2.inspect
    # render :text => params.inspect
    #puts params2

    request = Fatsecret::Api.new({}).api_call(
        #ENV['FATSECRET_KEY'],
        #ENV['FATSECRET_SECRET'],
        'cac271e1f5114c8298cd23ca772809fd',
        'c6172e6faf1b49bb8d66b674e7a18846',
        params2,
        tokens['auth_token'] ||= "",
        tokens['auth_secret'] ||= ""
    )
    @response = request.body

    doc = Nokogiri::XML(@response)
    events = doc.search('session_key').text

    @response = events
    #sign_in_fatsecret(@response)
    logger.debug { @response.inspect }
    logger.debug { params2.inspect }

    #cookies.permanent.signed[:fatsecret_session_key] = [@response]
    cookies[:fatsecret_session_key] = { :value => @response, :expires => Time.now + 3600}
    self.current_fatsecret_session_key = @response

    #render :text => params2.inspect


    #redirect_to root_path
    #redirect_to /user_links/
    # redirect_to :back
    #render :nothing => true

  end

  def getexerciseswoparams
    params3 = params.except();
    #params3[:utf8] = "✓"
    params3[:action] = "create"
    params3[:controller] = "sessions"
    params3[:user_id] = session[:current_user_link_id]
    getexercises(params3)
  end



  def getexercises(params)
    tokens = {}
    unless session[:current_user_link_id].nil?

      user = UserLink.find(session[:current_user_link_id])
      tokens = user.api_tokens.find_by_provider('fatsecret')
    end

    params.merge(:user_id => session[:current_user_link_id])

    params2 = params.except(:authenticity_token, :session, :password, :submit)
    params2 = params2.merge(:user_id => session[:current_user_link_id])
    params2 = params2.merge(:method => 'exercise_entries.get')

    request = Fatsecret::Api.new({}).api_call(
        #ENV['FATSECRET_KEY'],
        #ENV['FATSECRET_SECRET'],
        'cac271e1f5114c8298cd23ca772809fd',
        'c6172e6faf1b49bb8d66b674e7a18846',
        params2,
        tokens['auth_token'] ||= "",
        tokens['auth_secret'] ||= ""
    )
    @response = request.body

    doc = Nokogiri::XML(@response)
    #sessionkey_events = doc.search('session_key').text

    debug = params2
    session[:debug] = debug

    #@test = doc.xpath('//xmlns:exercise_entries/xmlns:exercise_entry/xmlns:exercise_name').each do |i|
    #       i.search('exercise_name').text
    #end


    @exercises = []
    @test = doc.xpath('//xmlns:exercise_entries/xmlns:exercise_entry/xmlns:exercise_name').each do |i|
      @exercises.append(i.text)
    end
    #@test = @test.search('exercise_name')

    newentry = 1
    # Check if the sport is allready listed, if not, save
    @exercises.each do |e|
      newentry = 1
      if (SportLink.find_by_name(e) != nil) #this sport exists on cybercoach (or at least local)
        sport =  SportLink.find_by_name(e)
        if (SubscriptionLink.find_by_sport_link_id(sport.id) != nil) # there is at least one subscription for this sport
          SubscriptionLink.find_all_by_sport_link_id(sport.id).each do |sub| #look at every subscription that matches the sport
            if(sub.user_link_id == session[:current_user_link_id])    #check if it is for the current user
              newentry = 0       # entry already exists, dont create a new one later
            end

          end
        end
        if (newentry == 1)
          SubscriptionLink.create(:user_link_id => session[:current_user_link_id], :sport_link_id => sport.id)
        end

      end


    end



    #@test = doc.map do |i|
    # i.search('exercise_name').text
    #end

  end

  private

  #FIXME --------------------------------------------
  def userlink_from_remember_token
    UserLink.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

end
