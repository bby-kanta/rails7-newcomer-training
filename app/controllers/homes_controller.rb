class HomesController < ApplicationController
    
    def index
        if user_signed_in?
            # 公開ユーザーの投稿 + 自分がフォローしている非公開ユーザーの投稿
            public_users = User.where(private: false)
            followed_private_users = current_user.followings.where(private: true)
            allowed_users = public_users.or(followed_private_users).or(User.where(id: current_user.id))
            
            @posts = Post.where(user: allowed_users)
            @posts_following = Post.where(user_id: current_user.followings.ids)
        else
            # 未ログインの場合は公開ユーザーの投稿のみ
            @posts = Post.joins(:user).where(users: { private: false })
            @posts_following = []
        end
    end
end
