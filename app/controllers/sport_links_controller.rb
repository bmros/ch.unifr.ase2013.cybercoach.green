class SportLinksController < ApplicationController
  before_action :set_sport_link, only: [:show, :edit, :update, :destroy]

  # GET /sport_links
  # GET /sport_links.json
  def index
    @sport_links = SportLink.all
  end

  # GET /sport_links/1
  # GET /sport_links/1.json
  def show
  end

  # GET /sport_links/new
  def new
    @sport_link = SportLink.new
  end

  # GET /sport_links/1/edit
  def edit
  end

  # POST /sport_links
  # POST /sport_links.json
  def create
    @sport_link = SportLink.new(sport_link_params)

    respond_to do |format|
      if @sport_link.save
        format.html { redirect_to @sport_link, notice: 'Sport link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sport_link }
      else
        format.html { render action: 'new' }
        format.json { render json: @sport_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_links/1
  # PATCH/PUT /sport_links/1.json
  def update
    respond_to do |format|
      if @sport_link.update(sport_link_params)
        format.html { redirect_to @sport_link, notice: 'Sport link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sport_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_links/1
  # DELETE /sport_links/1.json
  def destroy
    @sport_link.destroy
    respond_to do |format|
      format.html { redirect_to sport_links_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sport_link
    @sport_link = SportLink.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sport_link_params
    params.require(:sport_link).permit(:name)
  end
end
