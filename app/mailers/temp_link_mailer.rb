class TempLinkMailer < ApplicationMailer
    default from: "login-helper@#{Rails.configuration.env_variables.email_domain}"

    def login_email
        @url  = params[:url]
        mail(to: params[:email], subject: 'Login Link')
    end
end
