class UsersController < ApplicationController
  def index
    @users = User.with_attached_profile_pic.includes(:sent_friendships, :received_friendships).excluding(current_user)
    @sent_friendship_requests = User.users_with_pending_sent_friendships(current_user)
    @received_friendship_requests = User.users_with_pending_received_friendships(current_user)
    @friends = User.friends(current_user)
  end
end
