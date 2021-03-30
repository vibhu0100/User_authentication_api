class LikesController < ApplicationController
  def like
    unless already_liked?
      like = Like.new(post_id: params[:post_id], user_id: @current_user.id)
      if like.save
        render json: "liked"
      else
        render json: "error"
      end
    else
      render json: "error"
    end
  end

  def liked_post
    post = []
    Like.where(user_id: @current_user.id).each do |l|
      post.append(Post.find(l.post_id))
    end
    unless post.empty?
      #render json: post, each_serializer: PostSerializer
      render json: Kaminari.paginate_array(post).page(params[:page]).per(2)
    else
      render json: "haven't liked anything yet"
    end
  end

  def unlike
    puts "hello"
    like = Like.where("post_id = #{params[:post_id]} AND user_id = #{@current_user.id}")
    puts "hello"
    if like
      if like.destroy_all
        puts "destroyed"
        render json: "Unliked"
      else
        render json: "error"
      end
    else
      render json: "hasn't liked yet"
    end
  end
  
  private
  def already_liked?
    like = Like.where("post_id = #{params[:post_id]} AND user_id = #{@current_user.id}")
    if like.empty?
      return false
    else
      return true
    end
  end
end
