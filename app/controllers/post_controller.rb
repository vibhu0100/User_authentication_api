class PostController < ApplicationController
  def create
    @post = logged_in_user.posts.build(post_params)
    if @post.save
      render json: { message: 'Created', post: @post }
    else
      render json: { message: "Couldn't create post" }
    end
  end

  def index
    @posts = logged_in_user.posts.all
    if @posts.empty?
      render json: { message: "You don't have nay post" }
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
      render json: { message: "Couldn't update post" }
    end
  end

  def delete
    post = logged_in_user.posts.all
    @post = post.find(params[:id])
    if @post.destroy
      render json: { message: 'Successfully deleted' }
    else
      render json: { message: "Couldn't delete" }
    end
  end

  def image
    url = Hash.new
    posts = logged_in_user.posts.all
    @post = posts.find(params[:id])
    if @post.images.attached?
      @post.images.each do |img|
        url[img.blob_id] = rails_blob_path(img)
      end
      render json: url
    else
      render json: { message: "Post doesn't have images" }
    end
  end

  def add_image
    posts = logged_in_user.posts.all
    @post = posts.find(params[:id])
    if params[:images]
      @post.images.attach(params[:images])
      image
    else
      render json: { message: "Couldn't add images" }
    end
  end

  def delete_image
    posts = logged_in_user.posts.all
    @post = posts.find(params[:id])
    if @post
      img = @post.images.find_by(blob_id: params[:blob_id])
      if img.purge
        image
      else
        { message: "Couldn't delete images" }
      end
    else
      render json: { message: "You don't have any images" }
    end
  end

  private
  def post_params
    params.permit(:caption, images: [])
  end
end
