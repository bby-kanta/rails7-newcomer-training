class FollowRequestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @follow_requests = current_user.received_follow_requests.includes(:follower)
  end

  def create
    request = FollowRequest.find(params[:id])
    @user = request.follower
    if params[:approve]
      current_user.approve_follow_request(@user)
    else
      current_user.reject_follow_request(@user)
    end
    redirect_to follow_requests_path
  end

  def destroy
    request = FollowRequest.find(params[:id])
    @user = request.follower
    current_user.reject_follow_request(@user)
    redirect_to follow_requests_path
  end
end
