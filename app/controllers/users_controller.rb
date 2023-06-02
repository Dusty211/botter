class UsersController < ApplicationController

    def index
        users = User.all
        render json: users
    end

    def create
        new_user = create_user_params.merge(enabled: true)
        render json: User.create!(new_user)
    end

    def update
        render json: User.update!(params[:id], update_user_params)
    end

    def show
        render json: User.find(params[:id])
    end

    private

    def create_user_params
        params.require(:user).require([:email, :username, :password])
        params.require(:user).permit(:email, :username, :password)
    end

    def update_user_params
        params.require(:user).permit(:email, :username, :password, :enabled)
    end
end
