class SessionsController < ApplicationController
  include SessionsHelper 

  def index
    @users = User.all
  end


  # GET /sessions/new
  def new
   #redirect_to root_path
  end


  # POST /sessions
  # POST /sessions.json
  def create

	begin
  	 @user = User.find(params[:session][:username])

    respond_to do |format|

	#try to modify something...
	  @user.username = params[:session][:username]

      begin
        status = @user.save
      rescue ActiveResource::UnauthorizedAccess
        status = false
      end

      if status
	  
	    session[:current_user_id] = @user.id
	  
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        #format.html { redirect_to @user, alert: "Could not update" }
		format.html { redirect_to signin_path, alert: "Could not update" }

        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
	 end 
    rescue
	 redirect_to signin_path
	end	  


  end
  


  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
  	session[:current_user_id] = nil
    sign_out
    redirect_to root_path
  end 


    def session_params
      params.require(:session).permit(:password, :username)
    end


end
