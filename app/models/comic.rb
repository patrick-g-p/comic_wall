class Comic < ActiveRecord::Base
  has_many :discussions, -> { order('reply_count DESC') }

  validates_presence_of :title
  validates_presence_of :issue_number
  validates_numericality_of :issue_number, only_integer: true
  validates_presence_of :cover_art_url

  def self.search_by_title(search)
    return [] if search.blank?
    self.where("LOWER(title) LIKE ?", "%#{search.downcase}%" ).order(:title)
  end

end
