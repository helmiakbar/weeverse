class SocialsController < ApplicationController
  before_action :set_social, only: [:show, :edit, :update, :destroy]

  # GET /socials
  # GET /socials.json
  def index
    if user_signed_in?
      @countries = @regions = @cities = []
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
      if params[:tag]
        @socials = Social.where('city = ? OR country = ?', @location.city_name, @location.country_name).tagged_with(params[:tag])
      else
        @socials = Social.where('city = ? OR country = ?', @location.city_name, @location.country_name)
      end
      socials1 = Social.all   
      @countries = socials1.map(&:country).uniq
      @cities = socials1.map(&:city).uniq
    else
      @socials = Social.all
    end
  end

  # GET /socials/1
  # GET /socials/1.json
  def show
    @social1 = Social.where(id: params[:id])
    if user_signed_in?
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
      @ideas = Social.where(city: @location.city_name)
    else
      @ideas = Social.all
    end
  end

  # GET /socials/new
  def new
    @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
    @social = Social.new
    @social.project_id = params[:parent_id] if params[:parent_id]
  end

  # GET /socials/1/edit
  def edit
  end

  # POST /socials
  # POST /socials.json
  def create
    location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
    social_params[:lat].blank? ? social_params[:lat] << location.latitude.to_s : social_params[:lat]
    social_params[:long].blank? ? social_params[:long] << location.longitude.to_s : social_params[:long]
    social_params[:country].blank? ? social_params[:country] << location.country_name : social_params[:country]
    social_params[:city].blank? ? social_params[:city] << location.city_name : social_params[:city]
    @social = Social.new(social_params)

    respond_to do |format|
      if @social.save
        format.html { redirect_to @social, notice: 'Social was successfully created.' }
        format.json { render action: 'show', status: :created, location: @social }
      else
        format.html { render action: 'new' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socials/1
  # PATCH/PUT /socials/1.json
  def update
    respond_to do |format|
      if @social.update(social_params)
        format.html { redirect_to @social, notice: 'Social was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socials/1
  # DELETE /socials/1.json
  def destroy
    @social.destroy
    respond_to do |format|
      format.html { redirect_to socials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social
      @social = Social.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def social_params
      params.require(:social).permit(:title, :description, :country, :city, :postal_code, :image, :creator, :lat, :long, :parent_id)
    end
end
