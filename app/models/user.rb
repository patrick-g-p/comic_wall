class User < ActiveRecord::Base
  has_many :discussions
  has_many :replies
  has_many :to_read_items, -> { order(:list_position) }

  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name
  validates :password, presence: true, length: { minimum: 7 }

  def owns_to_read_item?(item)
    to_read_items.include?(item)
  end

  def already_has_comic_in_list?(a_comic)
    to_read_items.map(&:comic).include?(a_comic)
  end

  def new_to_read_item_position
    to_read_items.count + 1
  end

  def normalize_reading_list
    to_read_items.each_with_index do |item, index_number|
      item.update(list_position: index_number + 1)
    end
  end
end
