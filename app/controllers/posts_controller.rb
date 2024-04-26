class PostsController < ApplicationController
    
    def new
        @post = Post.new
        
    end

    def create
        # ストロングパラメーターを使用
        post = Post.new(post_params)
        post.user_id = current_user.id
        # DBへ保存する
        post.save
        # トップ画面へリダイレクト
        redirect_to '/homes'
    end

    private

    def post_params
        params.require(:post).permit(:user_id, :body)
    end
end
