module ApisHelper


  def getExercises(params)


    #exercises.get

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





end
