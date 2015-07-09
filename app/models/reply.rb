class Reply < ActiveRecord::Base
  belongs_to :creator, class: 'User', foreign_key: 'user_id'
  belongs_to :discussion

  validates :body, presence: true, allow_blank: false
end
