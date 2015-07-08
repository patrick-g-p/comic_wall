require 'spec_helper'

describe User do
  it { should have_many(:discussions) }

  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(7) }
end
