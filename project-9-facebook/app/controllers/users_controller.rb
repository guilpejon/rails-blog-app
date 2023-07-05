class UsersController < ApplicationController
  def index
    @users = User.with_attached_profile_pic.includes(:sent_friendships, :received_friendships).excluding(current_user)
    @sent_friendship_requests = User.users_with_pending_sent_friendships(current_user)
    @received_friendship_requests = User.users_with_pending_received_friendships(current_user)
    @friends = User.friends(current_user)
  end

  def profile
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Profile successfully updated.'
    else
      flash[:alert] = 'Failed to update profile.'
    end

    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_pic)
  end
end
