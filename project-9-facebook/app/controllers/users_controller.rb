class UsersController < ApplicationController
  def index
    # @users = User.excluding(current_user)
    @users = User.includes(:sent_friendships, :received_friendships).excluding(current_user)
    @sent_friendship_requests = User.users_with_pending_sent_friendships(current_user)
    @received_friendship_requests = User.users_with_pending_received_friendships(current_user)
    @friends = User.friends(current_user)
  end
end
