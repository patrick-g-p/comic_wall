class ComicsController < ApplicationController
  before_action :require_user, except: [:index, :show]

  def index
    @comics = Comic.limit(8).order("RANDOM()")
  end

  def show
    @comic = Comic.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Sorry, that comic doesn't exist!"
      redirect_to root_path
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)

    if @comic.save
      flash[:success] = "#{@comic.title} was added to the Comic Wall. Start or join a discussion!"
      redirect_to comic_path(@comic)
    else
      flash[:danger] = "Not so fast Flash! There were some errors."
      render :new
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :issue_number, :cover_art_url)
  end
end
