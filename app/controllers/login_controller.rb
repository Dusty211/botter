class LoginController < ApplicationController
    include BCrypt

    skip_before_action :authenticate, only: [:create]

    def create
        validated_params = create_login_params
        user = User.find_by_email(validated_params[:email])
        password = Password.new(user[:password_hash])
        if password == validated_params[:password]
            response.headers["Authorization"] = "Bearer #{get_token user.id}"
            render json: {login: true}
        else
            render json: {login: false}
        end
      end

    private

    def create_login_params
        params.require(:login).require([:email, :password])
        params.require(:login).permit(:email, :password)
    end
end
