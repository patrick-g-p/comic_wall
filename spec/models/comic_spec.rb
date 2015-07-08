require 'spec_helper'

describe Comic do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:issue_number) }
  it { should validate_numericality_of(:issue_number).only_integer }
  it { should validate_presence_of(:cover_art_url) }
end
