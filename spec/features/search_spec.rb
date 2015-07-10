require 'spec_helper'

feature 'Comic Search' do
  let(:a_comic) {Fabricate(:comic, title: 'Watchmen')}

  scenario 'User is searching for a specific comic/series' do
    visit_homepage
    enter_search
    successful_search_results
  end

  def visit_homepage
    visit('/')
  end

  def enter_search
    fill_in('search-bar', with: a_comic.title)
    click_on('Comic Search')
  end

  def successful_search_results
    expect(page).to have_content("#{a_comic.title} ##{a_comic.issue_number}")
  end
end
