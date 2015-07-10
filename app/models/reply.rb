class Reply < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :discussion, counter_cache: :reply_count

  validates :body, presence: true, allow_blank: false

  def contributers_name
    creator.full_name
  end
end
