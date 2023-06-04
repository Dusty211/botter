class UsersController < ApplicationController

    include BCrypt

    def index
        users = User.all
        render json: users
    end

    def create
        validated_params = create_user_params.merge(enabled: true)
        password = validated_params.extract!(:password)
        new_user = User.new(validated_params)
        new_user.password_hash = Password.create(password)
        new_user.save!
        render json: new_user.as_json(:except => [ :password_hash ])
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
