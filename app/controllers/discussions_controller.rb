class DiscussionsController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :set_comic

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.comic = @comic
    @discussion.creator = current_user

    if @discussion.save
      flash[:success] = "Discussion added!"
      redirect_to comic_discussion_path(@comic, @discussion)
    else
      flash[:danger] = "Mark IV malfunction. Something went wrong."
      render :new
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
    @reply = Reply.new
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Sorry, that discussion doesn't exist!"
      redirect_to comic_path(@comic)
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

  def set_comic
    @comic = Comic.find(params[:comic_id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Sorry, that comic doesn't exist!"
      redirect_to root_path
  end
end
