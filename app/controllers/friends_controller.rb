class FriendsController < ApplicationController
  def send_request
    request = Friend.where("friend_id = ? AND user_id = ?",params[:friend_id], @current_user.id)
    if request.empty?
      friend = User.find(params[:friend_id])
      if friend.public_acc?
        req = Friend.new(user_id: @current_user.id, friend_id: params[:friend_id], request: 'Accepted')
      else
        req = Friend.new(user_id: @current_user.id, friend_id: params[:friend_id], request: 'Requested')
      end
      if req.save
        render json: "Success"
      else
        render json: "error"
      end
    else
      render json: "Cannot request"
    end
  end

  def accept_request
    req = Friend.find(params[:request_id])
    if req.request == "Requested"
      if req.update(request: 'Accepted')
        render json: "Accepted"
      else
        render json: "error"
      end
    else
      render json: "Already friends"
    end  
  end

  def index
    $friend_flag = true
    @friends = @current_user.friend
    if @friends
      render json: @friends
    else
      render json: "You dont have any friends"
    end
  end

  def friend_request
    $friend_flag = false
    $check  = false
    
    rqst = @current_user.request
    unless rqst.empty?
      render json: rqst
    else
      render json: "no pending request"
    end
  end




  





end
