class Discussion < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :comic
  has_many :replies

  validates_presence_of :title
  validates_presence_of :body
end
