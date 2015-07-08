class User < ActiveRecord::Base
  has_many :discussions

  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name
  validates :password, presence: true, length: { minimum: 7 }
end
