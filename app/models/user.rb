class User < ActiveRecord::Base
  has_many :discussions
  has_many :replies
  has_many :to_read_items, -> { order(:list_position) }

  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name
  validates :password, presence: true, length: { minimum: 7 }
end
