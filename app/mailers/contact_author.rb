class ContactAuthor < ActionMailer::Base
  default :from => "Weeverse"
  def contact_author(recipient, social_id, social_content)
  	@social = Social.find(social_id)
  	@social_content = social_content
    mail(:to => recipient, :subject => "Weeverse Project Share")
  end
end
