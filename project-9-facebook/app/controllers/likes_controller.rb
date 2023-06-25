class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post:)

    if like.save!
      flash[:success] = 'Post liked successfully.'
    else
      flash[:alert] = 'Failed to like the post.'
    end

    redirect_to posts_path
  rescue ActiveRecord::RecordInvalid
    redirect_to posts_path, warning: like.errors.full_messages[0]
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])

    if like.destroy!
      flash[:success] = 'Post unliked successfully.'
    else
      flash[:alert] = 'Failed to unlike the post.'
    end

    redirect_to posts_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
