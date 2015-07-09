require 'spec_helper'

feature 'Discussion Creation' do
  let!(:a_comic) {Fabricate(:comic)}
  let(:new_discussion) {Fabricate.attributes_for(:discussion)}

  before do
    login
  end

  scenario 'A user decides to begin a new discussion on a comic' do
    click_comic_on_wall
    go_to_new_discussion_page
    fill_out_form
    new_discussion_was_added
  end

  def click_comic_on_wall
    find("a[href='/comics/#{a_comic.id}']").click
    expect(page).to have_content("Discussions:")
  end

  def go_to_new_discussion_page
    click_on('Begin A Discussion')
    expect(page).to have_content("- New Discussion")
  end

  def fill_out_form
    fill_in("Title", with: new_discussion[:title])
    fill_in("Body", with: new_discussion[:body])
    click_on('Add Discussion')
  end

  def new_discussion_was_added
    expect(page).to have_content('Discussion added!')
  end
end
