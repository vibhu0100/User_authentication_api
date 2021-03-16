class CommentsController < ApplicationController
  def create
    @comment = Comment.new(desc: params[:desc], comment_user_id: @current_user.id, post_id: params[:post_id])
    if @comment.save
      @post = Post.find(params[:post_id])
      render json: @post
    else
      render json: "couldn't comment"
    end
  end

  def index
    @post = Post.find(params[:post_id])
    render json: @post
  end

  def update
    @comment = Comment.find(params[:comment_id])
    if has_authority?(@current_user, @comment)
      if @comment.update(comment_params)
        render json: "edited"
      else
        render json: "Couldn't edit"
      end
    else
      render json: "You cannot edit this comment"
    end
  end

  def delete
    @comment = Comment.find(params[:comment_id])
    if has_authority?(@comment)
      if @comment.destroy
        render json: "Successfully deleted"
      else
        render json: "Couldn't Delete"
      end
    else
      render json: "You cannot delete this comment"
    end
  end

  private
  def comment_params
    params.permit(:desc)
  end

  def owner_of_post(comment)
    post_id = comment.post_id
    post = Post.find(post_id)
    return post.user_id
  end
  def has_authority?(comment)
    if (@current_user.id == @comment.comment_user_id) || (@current_user.id == owner_of_post(comment))
      return true
    else
      return false
    end
  end
end
