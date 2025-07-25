class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        
        # 非公開ユーザーの場合、フォロワーでなければ投稿を見せない
        if @user.private? && current_user != @user && !current_user&.following?(@user)
            @posts = []
            @favorite_posts = []
        else
            @posts = @user.posts
            @favorite_posts = @user.favorites.map(&:post)
        end
    end

    private
    def user_params
        params.require(:user).permit(:id, :email)
    end

end
