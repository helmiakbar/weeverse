require 'geoip'

class ProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if user_signed_in?
      @countries = @regions = @cities = []
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('24.84.20.149')
      @projects = Project.where('city = ? OR country = ?', @location.city_name, @location.country_name)
      projects1 = Project.all   
      @countries = projects1.map(&:country).uniq
      @regions = projects1.map(&:region_name).uniq
      @cities = projects1.map(&:city).uniq
    else
      @projects = Project.all
    end
  end

  def project_show
    @projects = []
    if params[:type].eql?("country")
      projects = Project.where(country: params[:country]) 
    elsif params[:type].eql?("region_name")
      projects = Project.where('country = ? AND region_name = ?', params[:country], params[:region_name])
    else
      projects = Project.where('country = ? AND region_name = ? AND city = ?', params[:country], params[:region_name], params[:city])
    end
    @projects = projects.uniq
    respond_to :js
  end

  def all
    @countries = @regions = @cities = []
    @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # @location = GeoIP.new('lib/GeoLiteCity.dat').city('24.84.20.149')
    @projects = Project.all
    @ideas = Idea.all
    @countries = @projects.map(&:country).uniq
    @regions = @projects.map(&:region_name).uniq
    @cities = @projects.map(&:city).uniq
  end

  def big
    @project = Project.where(id: params[:id])
  end

  def join
    @project = Project.find(params[:id])
    @project.users << current_user
    redirect_to project_path
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project1 = Project.where(id: params[:id])
    if user_signed_in?
      @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
      # @location = GeoIP.new('lib/GeoLiteCity.dat').city('24.84.20.149')
      @projects = Project.where(city: @location.city_name)
    else
      @projects = Project.all
    end
  end

  # GET /projects/new
  def new
    @location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # @location = GeoIP.new('lib/GeoLiteCity.dat').city('24.84.20.149')
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    location = GeoIP.new('lib/GeoLiteCity.dat').city(current_user.current_sign_in_ip)
    # location = GeoIP.new('lib/GeoLiteCity.dat').city('24.84.20.149')
    project_params[:lat].blank? ? project_params[:lat] << location.latitude.to_s : project_params[:lat]
    project_params[:long].blank? ? project_params[:long] << location.longitude.to_s : project_params[:long]
    project_params[:region_name].blank? ? project_params[:region_name] << location.region_name : project_params[:region_name]
    project_params[:country].blank? ? project_params[:country] << location.country_name : project_params[:country]
    project_params[:city].blank? ? project_params[:city] << location.city_name : project_params[:city]
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :country, :city, :postal_code, :image, :creator, :lat, :long, :region_name)
    end
end
