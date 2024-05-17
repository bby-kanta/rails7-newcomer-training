class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        
        favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
        @favorite_posts = Post.find(favorites)
    end

    private
    def user_params
        params.require(:user).permit(:id, :email)
    end

end
