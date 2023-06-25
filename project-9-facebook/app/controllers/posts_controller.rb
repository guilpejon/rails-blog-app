class PostsController < ApplicationController
  def index
    @posts = Post.includes(:likes).order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save!
      flash[:success] = 'Post was successfully created!'
    else
      flash[:alert] = 'Failed to create post.'
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
