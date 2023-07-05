class PostsController < ApplicationController
  def index
    @posts = (
      current_user.posts.includes(:likes) +
      User.friends(current_user).includes(:likes).map(&:posts)
    ).flatten.sort_by(&:created_at).reverse
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save!
      flash[:success] = 'Post was successfully created.'
    else
      flash[:alert] = 'Failed to create post.'
    end

    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
