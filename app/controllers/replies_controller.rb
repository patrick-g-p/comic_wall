class RepliesController < ApplicationController
  before_action :set_comic
  before_action :set_discussion
  before_action :require_user

  def create
    @reply = Reply.new(reply_params)
    @reply.creator = current_user
    @reply.discussion = @discussion

    if @reply.save
      flash[:success] = 'Reply was added!'
      redirect_to comic_discussion_path(@comic, @discussion)
    else
      flash.now[:danger] = 'Something went wrong... move along.'
      render 'discussions/show'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end
end
