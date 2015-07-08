require 'spec_helper'

feature 'Login' do
  let(:dick_grayson) {Fabricate(:user)}

  scenario 'User inputs valid account credentials' do
    login(dick_grayson)
    expect(page).to have_content('You. Are. Logged in.')
  end
end
