class UserLinksController < ApplicationController
  def index
    @userlinks = UserLink.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @userlink = UserLink.find(params[:id])
  end

  # GET /users/new
  def new
    @userlink = UserLink.new
  end

  # GET /users/1/edit
  def edit

  end


  def create
    @userlink = UserLink.new(user_link_params)
    @userlink.save
    redirect_to @userlink
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_link
    #Api::Base.user = "abcd"
    #Api::Base.password = "abcd"

    #@user = User.find("a")
    @userlink = UserLink.find(params[:user_link_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_link_params
    params.require(:user_link).permit(:username)
  end

end
