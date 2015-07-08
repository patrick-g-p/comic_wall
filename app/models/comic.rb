class Comic < ActiveRecord::Base
  has_many :discussions

  validates_presence_of :title
  validates_presence_of :issue_number
  validates_numericality_of :issue_number, only_integer: true
  validates_presence_of :cover_art_url
end
