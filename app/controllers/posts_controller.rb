class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:succes] = "Post created"
      redirect_to root_url
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private

  def post_params
    params_require(:post).permit(:content, :image, :image_desc, :media)
  end
end
