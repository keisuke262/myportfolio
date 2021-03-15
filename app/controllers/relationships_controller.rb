class RelationshipsController < ApplicationController

  before_action :require_user_logged_in

  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'Followed user.'
    redirect_to users_url
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'Unfollowed user.'
    redirect_to users_url
  end
end

