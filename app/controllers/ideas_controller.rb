class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    if user_signed_in?
      @countries = @regions = @cities = []
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
      @ideas = Idea.where('city = ? OR country = ?', @location.city_name, @location.country_name)
      ideas1 = Idea.all   
      @countries = ideas1.map(&:country).uniq
      @regions = ideas1.map(&:region_name).uniq
      @cities = ideas1.map(&:city).uniq
    else
      @ideas = Idea.all
    end
  end

  def idea_show
    @ideas = []
    if params[:type].eql?("country")
      ideas = Idea.where(country: params[:country]) 
    elsif params[:type].eql?("region_name")
      ideas = Idea.where('country = ? AND region_name = ?', params[:country], params[:region_name])
    else
      ideas = Idea.where('country = ? AND region_name = ? AND city = ?', params[:country], params[:region_name], params[:city])
    end
    @ideas = ideas.uniq
    respond_to :js
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea1 = Idea.where(id: params[:id])
    if user_signed_in?
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
      @ideas = Idea.where(city: @location.city_name)
    else
      @ideas = Idea.all
    end
  end

  # GET /ideas/new
  def new
    @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
    idea_params[:lat].blank? ? idea_params[:lat] << location.latitude.to_s : idea_params[:lat]
    idea_params[:long].blank? ? idea_params[:long] << location.longitude.to_s : idea_params[:long]
    idea_params[:region_name].blank? ? idea_params[:region_name] << location.region_name : idea_params[:region_name]
    idea_params[:country].blank? ? idea_params[:country] << location.country_name : idea_params[:country]
    idea_params[:city].blank? ? idea_params[:city] << location.city_name : idea_params[:city]
    @idea = Idea.new(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render action: 'show', status: :created, location: @idea }
      else
        format.html { render action: 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :description, :image, :lat, :long, :country, :city, :postal_code, :creator, :region_name)
    end
end
