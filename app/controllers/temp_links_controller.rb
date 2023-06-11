class TempLinksController < ApplicationController

    skip_before_action :authenticate, only: [:create]

    def create
        email = create_temp_link_params[:email]
        if email.class == String && email.length > 0
            user_id = User.find_by!(email: email).id
            link_id = TempLink.create(user_id: user_id).id
            url = "localhost:3000/temp_links/#{link_id}"
            # Send email with url to user's email. ActionMailer.
            render json: {status: "email_sent"}
        else
            raise CustomErrors::BadRequestError.new
        end
    end

    private

    def create_temp_link_params
        params.require(:temp_link).require([:email])
        params.require(:temp_link).permit(:email)
    end

end
