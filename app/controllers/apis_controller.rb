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
        #'cac271e1f5114c8298cd23ca772809fd',   # localhost api key
        #'c6172e6faf1b49bb8d66b674e7a18846',   # localhost secret
        '2335333d72d249908b349d841c398027',    # herokuapp api key
        'd9378f2bfe9e443485fdb422cc526c44',    # herokuapp secret

        params,
        tokens['auth_token'] ||= "",
        tokens['auth_secret'] ||= ""
    )
    @response = request.body

=begin    doc = Nokogiri::XML(@response)
    #sessionkey_events = doc.search('session_key').text



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






    #t=0
    #@exercises.each do |e|
     # if (SportLink.find_by_user_link_id(session[:current_user_link_id]) != nil)
      #  t = 0
       # SportLink.find_all_by_user_link_id(session[:current_user_link_id]).each do  |i|
        #  if(i.name == e)
         #   t = 1
         # end

       # end
       # if(t==0)
       #   SportLink.create(:name => e, :user_link_id => session[:current_user_link_id])
       # end
      #end
    #end

=end

    #@test = doc.map do |i|
     # i.search('exercise_name').text
    #end

    @response = @exercises
    #@response = @test

    redirect_to user
    #exercises_events =  doc.search('exercise_name').text

    #@response = sessionkey_events
    #@response = exercises_events
    #sign_in_fatsecret(@response)

    #TODO: create cookie only if events = session_key

    #cookies.permanent.signed[:fatsecret_session_key] = [@response]
    #cookies[:fatsecret_session_key] = { :value => @response, :expires => Time.now + 3600}
    #self.current_fatsecret_session_key = @response
    #redirect_to :back
    #redirect_to /user_links/

  end
end
