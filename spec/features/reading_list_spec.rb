require 'spec_helper'

feature 'Reading List' do
  let(:jason_todd) {Fabricate(:user)}
  let!(:a_comic) {Fabricate(:comic)}
  let!(:another_comic) {Fabricate(:comic)}
  let!(:old_reading_list_item) {Fabricate(:to_read_item, list_position: 1, comic: another_comic, user: jason_todd)}

  before do
    login(jason_todd)
  end

  scenario 'A user finds a comic interesting and adds it to their list, reorders the list. and removes a to read item' do
    click_comic_on_wall(a_comic)
    add_to_list(a_comic)
    fill_in_new_list_position(a_comic, 1)
    fill_in_new_list_position(another_comic, 2)
    update_list
    expected_results(a_comic, 1)
    expected_results(another_comic, 2)
    click_remove_button(old_reading_list_item)
    item_was_removed_from_list
  end

  def click_comic_on_wall(comic)
    find("a[href='#{comic_path(comic)}']").click
    expect(page).to have_content("Discussions:")
  end

  def add_to_list(comic)
    click_on("Add #{comic.title} to your reading list?")
    expect(page).to have_content("#{a_comic.title} was added to your reading list!")
  end

  def fill_in_new_list_position(comic, new_position)
    find("input[data-comic-id='#{comic.id}']").set(new_position)
  end

  def update_list
    click_on('Update List')
  end

  def expected_results(comic, position)
    expect(find("input[data-comic-id='#{comic.id}']").value.to_i).to eq(position)
  end

  def click_remove_button(to_read_item)
    find("a[href='#{to_read_item_path(to_read_item.id)}']").click
  end

  def item_was_removed_from_list
    expect(page).to have_content('Comic was removed from your list.')
  end
end
