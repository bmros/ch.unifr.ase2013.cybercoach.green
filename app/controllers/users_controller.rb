class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #nothing to do since we have the set_user method
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    #nothing to do since we have the set_user method
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|

      #@user = User.new({:username => user_params[:username], :email => user_params[:email], :publicvisible => user_params[:publicvisible], :realname => user_params[:realname], :password => user_params[:password]}, true)
      #if user_params[:password] != '*'
      #  @user.password = user_params[:password]
      #else
      #  @user.password = nil
      #end
      @user = User.new(user_params, true)

      begin
        status = @user.save!
      rescue ActiveResource::UnauthorizedAccess,  ActiveResource::ResourceConflict
        status = false
      end

      if status
        format.html { redirect_to :controller => 'sessions', :action => 'new',  notice: 'User was successfully Created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', alert: "Could not Create" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      status = @user.destroy
    rescue ActiveResource::UnauthorizedAccess
      status = false
    end

    respond_to do |format|
      if status
        session.destroy
        #format.html { redirect_to :controller => 'sessions', :id => session.id, :action => 'destroy' }
        format.html {redirect_to root_path}
        format.json { head :no_content }
      else
        format.html { redirect_to @user, alert: "Could not delete"}
        format.json { render json: @users.errors, status: "Could not delete" }
      end
    end
  end

  def not_found
    flash[:error] = 'No user found'
    redirect_to :action => 'index'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    #User.user = session[:user_id]
    #User.password = session[:passwd]
    Api::Base.user = session[:user_id]
    Api::Base.password = session[:passwd]

    begin
      @user = User.find(params[:id])
    rescue ActiveResource::ResourceNotFound
      redirect_to :action => 'not_found'
    rescue ActiveResource::ResourceConflict, ActiveResource::ResourceInvalid
      redirect_to :action => 'new'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:uri, :username, :password, :realname, :email, :publicvisible)
  end

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
