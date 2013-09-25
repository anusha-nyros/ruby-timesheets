#**************sending emails for user activation details ******************
class UserMailer < ActionMailer::Base
  #default from: "saimca03@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
  @url  = "http://goteamcloud.com/users/#{user.activation_token}/activate"
  mail(:from => "Team Cloud<noreply@goteamcloud.com>",
       :to => user.email,
       :subject => "Welcome to goteamcloud.com ")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
     @user = user
  @url  = "http://goteamcloud.com/login"
  mail(:from => "Team Cloud<noreply@goteamcloud.com>",
       :to => user.email,
       :subject => "Your account is now activated")
  end
        def reset_password_email(user)
    @user = user
    #@url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
    @url  = "http://goteamcloud.com/password_resets/#{user.reset_password_token}/edit"
    mail(:from => "Team Cloud<noreply@goteamcloud.com>",
         :to => user.email,
         :subject => "Password reset request")
  end

end
