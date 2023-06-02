class PostsController < ApplicationController

    def index
        posts = Post.all
        render json: posts
    end

    def create
        #############################################################################
        # Need to implement auth for user_id. Sending in request body for dev/test: #
        #############################################################################
        new_post = create_post_params.merge(user_id: params[:user_id])
        render json: Post.create!(new_post)
    end

    def update
        render json: Post.update!(params[:id], update_post_params)
    end

    def show
        render json: Post.find(params[:id])
    end

    def destroy
        render json: Post.destroy(params[:id])
    end

    private

    def create_post_params
        params.require(:post).require(:text)
        params.require(:post).permit(:text)
    end

    def update_post_params
        params.require(:post).permit(:text)
    end
end
