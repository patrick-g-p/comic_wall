class ToReadItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :comic

  validates_numericality_of :list_position, {only_integer: true}
end
