require 'spec_helper'

describe ToReadItem do
  it { should belong_to(:user) }
  it { should belong_to(:comic) }

  it { should validate_numericality_of(:list_position).only_integer }
end
