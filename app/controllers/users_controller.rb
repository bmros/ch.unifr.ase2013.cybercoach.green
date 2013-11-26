class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user_link = UserLink.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create

    @user_link = UserLink.new(user_params)
    @user = User.new(user_params, true)


    respond_to do |format|
      if @user.save && @user_link.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json ----------------------------- TODO CLEAN ---------------------------------------
  def update
    respond_to do |format|

      @user.email = user_params[:email]
      @user.publicvisible = user_params[:publicvisible]
      @user.realname = user_params[:realname]
      if user_params[:password] != '*'
        @user.password = user_params[:password]
      else
        @user.password = nil
      end


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
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

=begin
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
=end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    Api::Base.user = 	session[:current_user_link_username]
    Api::Base.password = session[:current_user_link_password]

    #@user = User.find("a")
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :realname, :email, :publicvisible)
  end



=begin
    # Use callbacks to share common setup or constraints between actions.
    def set_user_link
      @user_link = UserLink.find(params[:id])
    end
=end

=begin
	def user_link_params
      params.require(:user).permit(:username, :password, :realname, :email, :publicvisible)
    end
=end




end
