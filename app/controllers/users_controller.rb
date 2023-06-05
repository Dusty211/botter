class UsersController < ApplicationController

    include BCrypt

    def index
        users = User.all
        render json: users.map {|user| user.safe_attributes}
    end

    def create
        validated_params = create_user_params.merge(enabled: true)
        password = validated_params.extract!(:password)
        new_user = User.new(validated_params)
        new_user.password_hash = Password.create(password[:password])
        new_user.save!
        render json: new_user.safe_attributes
    end

    def update
        validated_params = update_user_params
        password = validated_params.extract!(:password)
        if password[:password] != nil
            validated_params.merge!(password_hash: Password.create(password[:password]))
        end
        updated_user = User.update!(params[:id], validated_params)
        render json: updated_user.safe_attributes
    end

    def show
        render json: User.find(params[:id]).safe_attributes
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
