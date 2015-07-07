require 'spec_helper'

feature 'A user logs into their account' do
  let(:dick_grayson) {Fabricate(:user)}

  scenario 'The user inputs the correct information' do
    login(dick_grayson)
    expect(page).to have_content('You. Are. Logged in.')
  end
end
