class SessionsController < ApplicationController


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
    respond_to do |format|

	#@user = User.find(params[:session][:username])
	@user = User.find("abcd")
	#@user.username = params[:session][:username]
	@user.username = "roman"


      begin
        status = @user.save
      rescue ActiveResource::UnauthorizedAccess
        status = false
      end

      if status
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, alert: "Could not update" }
		#format.html { redirect_to root_path, alert: "Could not update" }

        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  


  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
  end


    def session_params
      params.require(:session).permit(:password, :username)
    end


end
