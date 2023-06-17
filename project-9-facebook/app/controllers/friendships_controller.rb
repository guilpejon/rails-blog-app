class FriendshipsController < ApplicationController
  def index
    @pending_friendship_requests = User.friendship_requests(current_user)
  end

  def create
    @friendship = current_user.sent_friendships.build(
      receiver_id: params[:receiver_id],
      status: 'pending'
    )

    if @friendship.save!
      flash[:success] = 'Friend request sent!'
    else
      flash[:alert] = 'Failed to send friend request.'
    end

    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.receiver == current_user && @friendship.update(status: 'accepted')
      flash[:success] = 'Friend request accepted!'
    else
      flash[:alert] = 'Failed to accept friend request.'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if (@friendship.sender == current_user || @friendship.receiver == current_user) && @friendship.destroy
      flash[:notice] = 'Friendship rejected!'
    else
      flash[:alert] = 'Failed to reject friendship.'
    end
    redirect_back(fallback_location: root_path)
  end
end
