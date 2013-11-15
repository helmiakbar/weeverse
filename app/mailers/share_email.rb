class ShareEmail < ActionMailer::Base
  default :from => "Weeverse"
  def share_project(recipient, project_id, project_content)
  	@project = Project.find(project_id)
  	@project_content = project_content
    mail(:to => recipient, :subject => "Weeverse Project Share")
  end
end
