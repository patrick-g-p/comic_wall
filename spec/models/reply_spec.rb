require 'spec_helper'

describe Reply do
  it { should belong_to(:creator) }
  it { should belong_to(:discussion) }

  it { should validate_presence_of(:body) }
  it { should_not allow_value('').for(:body) }
end
