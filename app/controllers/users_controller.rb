class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        
        @favorite_posts = @user.favorites.map(&:post)
    end

    private
    def user_params
        params.require(:user).permit(:id, :email)
    end

end
