require 'spec_helper'

describe Comic do
  it { should have_many(:discussions) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:issue_number) }
  it { should validate_numericality_of(:issue_number).only_integer }
  it { should validate_presence_of(:cover_art_url) }

  describe 'search_by_title' do
    let(:batman_beyond) {Fabricate(:comic, title: 'Batman Beyond')}
    let(:killing_joke) {Fabricate(:comic, title: 'Batman: The Killing Joke')}

    it 'returns an empty array' do
      expect(Comic.search_by_title('aquaman')).to be_empty
    end

    it "returns an array with one comic if there's one match" do
      expect(Comic.search_by_title('batman beyond')).to eq([batman_beyond])
    end

    it "returns an array with multiple comics if there's more than one match" do
      expect(Comic.search_by_title('batman')).to eq([batman_beyond, killing_joke])
    end

    it 'returns partial matches' do
      expect(Comic.search_by_title('bat')).to eq([batman_beyond, killing_joke])
    end
  end
end
