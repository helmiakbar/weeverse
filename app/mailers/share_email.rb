class ShareEmail < ActionMailer::Base
  default :from => "Weeverse"
  def share_project(recipient, project_id)
  	@project = Project.find(project_id)
    mail(:to => recipient, :subject => "Weeverse Project Share")
  end
end
