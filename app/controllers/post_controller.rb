class PostController < ApplicationController
  def create
    @post = logged_in_user.posts.build(post_params)
    if @post.save
      render json: { message: 'Created', post: @post }
    else
      render json: 'Something went wrong'
    end
  end

  def index
    @posts = logged_in_user.posts.all
    if @posts.empty?
      render json: 'You dont have any post'
    else
      render json: { message: 'Your posts', post: @posts }
    end
  end

  def update
    post = logged_in_user.posts.all
    @post = post.find(params[:id])
    if @post.update(post_params)
      render json: { message: 'Successfully Updated', post: @post }
    else
      render json: 'Something went wrong'
    end
  end

  def delete
    post = logged_in_user.posts.all
    @post = post.find(params[:id])
    if @post.destroy
      render json: { message: 'Successfully deleted' }
    else
      render json: "Couldn't Delete"
    end
  end

  private

  def post_params
    params.permit(:caption)
  end
end
