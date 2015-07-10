require 'spec_helper'

feature 'Adding a reply' do
  let(:tim_drake) {Fabricate(:user)}
  let(:another_user) {Fabricate(:user)}
  let!(:a_comic) {Fabricate(:comic)}
  let!(:a_discussion) {Fabricate(:discussion, comic: a_comic, creator: another_user)}
  let(:tims_reply) {Fabricate.attributes_for(:reply)}

  scenario 'User adds a reply to an in progress discussion' do
    login(tim_drake)
    click_comic_on_wall(a_comic)
    click_discussion_link
    type_out_and_submit_reply
    reply_added
  end

  def click_comic_on_wall(comic)
    find("a[href='#{comic_path(comic)}']").click
    expect(page).to have_content("Discussions:")
  end

  def click_discussion_link
    click_link("#{a_discussion.title}")
    expect(page).to have_content('Replies:')
  end

  def type_out_and_submit_reply
    fill_in('reply-text-area', with: tims_reply[:body])
    click_on('Submit')
  end

  def reply_added
    expect(page).to have_content('Reply was added!')
  end
end
