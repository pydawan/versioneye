class NewsletterMailer < ActionMailer::Base
  default from: "\"VersionEye\" <notify@versioneye.com>"
  
  def newsletter_email(user)
  	p " -- start --- "
    @user = user
    mail(
      :to => @user.email, 
      :subject => "VersionEye News",
      :tag => "newsletter"
      )
  end
  
end