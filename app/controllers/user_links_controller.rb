class UserLinksController < ApplicationController

  before_action :set_user_link, only: [:show, :edit, :update, :destroy]

  # GET /user_links
  # GET /user_links.json
  def index
    @user_links = UserLink.all
  end

  # GET /user_links/1
  # GET /user_links/1.json
  def show
  end
  
  # GET /user_links/new
  def new
    @user_link = UserLink.new
  end

  # GET /user_links/1/edit
  def edit
  end

  # POST /user_links
  # POST /user_links.json
  def create
    @user_link = UserLink.new(user_link_params)

    respond_to do |format|
      if @user_link.save
        format.html { redirect_to @user_link, notice: 'User link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_link }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_links/1
  # PATCH/PUT /user_links/1.json
  def update
    respond_to do |format|
      if @user_link.update(user_link_params)
        format.html { redirect_to @user_link, notice: 'User link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_links/1
  # DELETE /user_links/1.json
  def destroy
    @user_link.destroy
    respond_to do |format|
      format.html { redirect_to user_links_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_link
    @user_link = UserLink.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_link_params
    params.require(:user_link).permit(:username, :password, :realname, :email, :publicvisible)
  end
end
