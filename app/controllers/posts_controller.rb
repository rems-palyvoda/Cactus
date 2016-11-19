class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:succes] = "Post created"
      redirect_to root_url
    else
      @post_items = []
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_desc, :media)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
