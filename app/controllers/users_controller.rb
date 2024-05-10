class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        # @user = User.find(user_params[:id])
        # @posts = Post.find(post_params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:id, :email)
        # user_params.require(:user).permit(:id, :email)
    end

    # def post_params
    #     post_params.require(:post).permit(:user_id, :body)
    # end
end