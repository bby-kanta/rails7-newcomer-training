class PostsController < ApplicationController
    def new
        @post = Post.new
    end

    def create
        # ストロングパラメーターを使用
         post = Post.new(post_params)
        # DBへ保存する
         post.save
        # トップ画面へリダイレクト
        redirect_to '/homes'
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end
end
