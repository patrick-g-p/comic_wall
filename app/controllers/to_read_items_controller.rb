class ToReadItemsController < ApplicationController
  before_action :require_user

  def index
    @to_read_items = current_user.to_read_items
  end

  def create
    @comic = Comic.find(params[:comic_id])
    add_reading_item unless current_user.already_has_comic_in_list?(@comic)
    flash[:success] = "#{@comic.title} was added to your reading list!"
    redirect_to reading_list_path
  end

  def destroy
    to_read_item = ToReadItem.find(params[:id])
    to_read_item.destroy if current_user.owns_to_read_item?(to_read_item)
    flash[:danger] = 'Comic was removed from your list.'
    current_user.normalize_reading_list
    redirect_to reading_list_path
  end

  def update_list
    begin
      update_reading_items
      current_user.normalize_reading_list
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid list position. Try again."
    end
    redirect_to reading_list_path
  end

  private

  def add_reading_item
    ToReadItem.create(list_position: current_user.new_to_read_item_position, comic: @comic, user: current_user)
  end

  def update_reading_items
    ActiveRecord::Base.transaction do
      params[:to_read_items].each do |item_info|
        item = ToReadItem.find(item_info['id'])
        item.update!(list_position: item_info['list_position']) if item.user == current_user
      end
    end
  end
end
