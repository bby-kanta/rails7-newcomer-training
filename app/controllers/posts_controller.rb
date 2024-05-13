class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
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

    def edit
        if current_user == Post.find(params[:id]).user || current_user.try(:admin?)
            @post = Post.find(params[:id])
        else
            redirect_to root_path
        end
    end

    def update
        if current_user == Post.find(params[:id]).user || current_user.try(:admin?)
            @post = Post.find(params[:id])
        else
            redirect_to root_path
        end
        post = Post.find(params[:id])
        post.update(post_params)
        redirect_to post_path(post.id)
    end

    def destroy
        if current_user == Post.find(params[:id]).user || current_user.try(:admin?)
            @post = Post.find(params[:id])
        else
            redirect_to root_path
        end
        post = Post.find(params[:id])
        post.destroy
        redirect_to "/homes"
    end

    private
    def post_params
        params.require(:post).permit(:user_id, :body)
    end
end
