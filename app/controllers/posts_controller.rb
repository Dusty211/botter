class PostsController < ApplicationController

    def index
        render json: Post.where(user_id: token_user_id)
    end

    def create
        new_post = create_post_params.merge(user_id: token_user_id)
        render json: Post.create!(new_post)
    end

    def update
        check_authorized
        render json: Post.update!(params[:id], update_post_params)
    end

    def show
        check_authorized
        render json: Post.find(params[:id])
    end

    def destroy
        check_authorized
        render json: Post.destroy(params[:id])
    end

    private

    def check_authorized
        post = Post.find(params[:id])
        if post[:user_id] != token_user_id
            raise CustomErrors::ForbiddenError.new
        end
    end

    def create_post_params
        params.require(:post).require(:text)
        params.require(:post).permit(:text)
    end

    def update_post_params
        params.require(:post).permit(:text)
    end
end
