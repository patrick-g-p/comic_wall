require 'spec_helper'

describe Discussion do
  it { should belong_to(:creator) }
  it { should belong_to(:comic) }
  it { should have_many(:replies) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
