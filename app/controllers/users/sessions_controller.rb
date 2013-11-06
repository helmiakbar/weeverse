class Users::SessionsController < ::Devise::SessionsController
  # the rest is inherited, so it should work
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to projects_path }
    end
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => "http://#{current_user.name}.weeverse-dev.herokuapp.com"
    # respond_with resource, :location => "http://#{current_user.name}.lvh.me:3000"
    # respond_with resource, :location => after_sign_in_path_for(resource)
  end
end