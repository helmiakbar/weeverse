# require 'youtube_it'
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
        @photo = @socials.map{ |s| s.photos.where(default: true) }
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

  def contact_author
    ShareEmail.share_project(params[:recipient], params[:social_id], params[:social_content]).deliver
    redirect_to social_path(params[:social_id])
  end

  # GET /socials/1
  # GET /socials/1.json
  def show
    @social1 = Social.where(id: params[:id])
    if user_signed_in?
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('110.136.133.185')
      @socials = Social.where(city: @location.city_name)
      @contact_author = User.where(name: @social.creator)
      @photo = @social.photos.where(default: true)
    else
      @socials = Social.all
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

  def get_thumbnail
    @url = params[:url]
    if params[:url].match(Regexp.union(/youtube.com/, /vimeo.com/))
      @video = VideoInfo.new(params[:url])
    else
      if params[:url].match(/soundcloud.com/)
        @soundcloud = HTTParty.get("http://api.soundcloud.com/resolve.json?url=#{params[:url]}&client_id=8f624be8e4a0dbb19d303b829a85501b")
      else

      end
    end
  end

  def upload_photo
    @photo = Photo.create(image: params[:files].last)
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
    if params[:selected].present?
      photos = Photo.find(params[:photos_id])
      photos.default = true
      photos.save
    end

    respond_to do |format|
      asdasd
      if @social.save
        params[:url].each do |key, value|
          @social.media_urls.create(url: value)
        end
        params[:photos].each do |key, value|
          photo = Photo.find(value)
          photo.social_id = @social.id
          photo.save
        end
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
      params.require(:social).permit(:title, :description, :country, :city, :postal_code, :image, :creator, :lat, :long, :project_id)
    end

    def media_url_params
      params.require(:media_url).permit(:url, :social_id)
    end

    def photos_params
      params.require(:photo).permit(:photo, :social_id)
    end
end
