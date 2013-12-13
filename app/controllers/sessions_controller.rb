require 'httparty'

class SessionsController < ApplicationController
  include SessionsHelper
  include HTTParty
  #format :xml
  #base_uri 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/'
  #default_params :authorization => 'xxxxxxx'


  def initializeAfterLogin
    self.class.base_uri "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/"
    self.class.basic_auth session[:current_user_link_username], session[:current_user_link_password]
    self.class.headers({'X-API-VERSION' => '1',
                        'Accept' => 'application/json'})
  end

  def create_sport(sport)
    self.class.headers({ 'X-API-VERSION' => '1',
                         'Accept' => 'application/json',
                         'Content-Type' => "application/x-www-form-urlencoded"})

    options = {
        :body => {"publicvisible" => "2"}}


    urlsport = '/users/' +  session[:current_user_link_username] + '/' + sport.name

    self.class.put(urlsport, options)
  end

  def check_sport
    ##################################################
    # check all listed sport_links for a user:       #
    # put them on cybercoach as a sport subscription #
    ################################################ #
    @sports
    #@sports.each do |s|
      if (SubscriptionLink.find_by_user_link_id(session[:current_user_link_id]) != nil)    #user has at least one subscription
        SubscriptionLink.find_all_by_user_link_id(session[:current_user_link_id]).each do |sub|
          sport=SportLink.find(sub.sport_link_id)
          create_sport(sport)
        end

        #@sports.each do |s|
        #   create_sport(s)
        #end

      end


    #end





  end

=begin
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





=end


=begin
  class Webservice
    include HTTParty
    format :xml
    base_uri 'mysite.com'
    default_params :authorization => 'xxxxxxx'

    def self.add_candidate(first_name,last_name,email,gender)
      post('/test.xml', :body => "")
    end
  end
=end
=begin
  def self.add_sport(sport,user)
    put('/test.xml', :body => {
        :Candidate => {
            :FirstName => first_name,
            :LastName  => last_name,
            :Email     => email,
            :Gender    => gender,
        }
    }
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

	  #redirect_to myexercise_path(user_link.id)
      session[:current_user_link_id] = user_link.id
      session[:current_user_link_username] = user_link.username
      session[:current_user_link_password] = params[:session][:password] #not crypted!

	    if ApiToken.find_by_user_link_id(user_link.id) == nil
        # no fatsecret profile yet, dont request a session key
      else
        sign_in_fatsecret(params)

        getexercises(params)
        initializeAfterLogin
        check_sport
      end

      #redirect_to user_link
	  @user = User.find(user_link.username) #user controller can manage user_link data
	  redirect_to @user

    end
  end

  def destroy
    #getexerciseswoparams FIXME ----------------------------------------------------------------
    session[:current_user_link_id] = nil
    session[:current_user_link_password] = nil
    session[:current_user_link_username] = nil
    session[:current_fatsecret_session_key] = nil
    sign_out
    sign_out_fatsecret

    redirect_to root_path
  end


end
