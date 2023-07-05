class CommentsController < ApplicationController
  def create
    post = Post.find(comment_params[:post_id])
    comment = post.comments.build(comment_params.merge(user_id: current_user.id))

    if comment.save!
      flash[:success] = 'Comment published successfully.'
    else
      flash[:alert] = 'Failed to publish the comment.'
    end

    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
