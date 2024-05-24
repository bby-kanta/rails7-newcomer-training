class HomesController < ApplicationController
    
    def index
        @posts = Post.all

        if user_signed_in?
            @posts_following = Post.where(user_id: current_user.followings.ids)
        else
            @posts_following = []
        end
    end
end
