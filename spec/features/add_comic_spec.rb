require 'spec_helper'

feature 'Comic Creation' do
  let(:new_comic) {Fabricate.attributes_for(:comic)}

  before do
    login
  end

  scenario 'User adds a new comic to the wall' do
    click_on('Add New Comic To The Wall')

    expect(page).to have_content('Add a new comic to the wall!')
    fill_in('Title/Series', with: new_comic[:title])
    fill_in('Issue #', with: new_comic[:issue_number])
    fill_in('Cover Art URL', with: new_comic[:cover_art_url])
    click_on('Submit Comic')

    expect(page).to have_content("was added to the Comic Wall.")
  end
end
