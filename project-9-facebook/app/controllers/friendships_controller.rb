class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.sent_friendships.build(
      receiver_id: params[:receiver_id],
      status: 'pending'
    )

    if @friendship.save!
      flash[:notice] = 'Friend request sent.'
    else
      flash[:alert] = 'Failed to send friend request.'
    end

    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.receiver == current_user && @friendship.update(status: 'accepted')
      flash[:notice] = 'Friend request accepted.'
    else
      flash[:alert] = 'Failed to accept friend request.'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if (@friendship.sender == current_user || @friendship.receiver == current_user) && @friendship.destroy
      flash[:notice] = 'Friend request rejected.'
    else
      flash[:alert] = 'Failed to reject friend request.'
    end
    redirect_back(fallback_location: root_path)
  end
end
