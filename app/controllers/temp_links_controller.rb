class TempLinksController < ApplicationController

    skip_before_action :authenticate, only: [:create, :show]

    def create
        email = create_temp_link_params[:email]
        if email.class == String && email.length > 0
            user_id = User.find_by!(email: email).id
            link_id = TempLink.create(user_id: user_id).id
            TempLinkMailer.with(
                url: "#{Rails.configuration.env_variables.url_base}/temp_links/#{link_id}", 
                email: email
            ).login_email.deliver_later
            render json: {status: "email_sent"}
        else
            raise CustomErrors::BadRequestError.new
        end
    end

    def show
        link = TempLink.find_by!(id: params[:id])
        if link.clicked_at != nil
            raise CustomErrors::GoneError.new("Link already clicked")
        elsif link.created_at < Time.now - 1.hours
            raise CustomErrors::GoneError.new("Link has expired")
        else
            TempLink.update!(link.id, clicked_at: Time.now)
            update_headers_with_token link.user_id
            render json: {login: true}
        end
    end

    private

    def create_temp_link_params
        params.require(:temp_link).require([:email])
        params.require(:temp_link).permit(:email)
    end

end
