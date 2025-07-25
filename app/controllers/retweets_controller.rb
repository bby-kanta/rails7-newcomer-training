class RetweetsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    retweet = current_user.retweets.new(post_id: @post.id)
    retweet.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    retweet = current_user.retweets.find_by(post_id: @post.id)
    retweet.destroy
    redirect_to request.referer
  end
end
