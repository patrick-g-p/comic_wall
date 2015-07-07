require 'spec_helper'

feature 'A new Comic Wall user is registered' do
  let(:a_new_user) {Fabricate.build(:user)}

  scenario 'The future user inputs valid information' do
    visit('/register')
    fill_in('Email', with: a_new_user.email)
    fill_in('Full Name', with: a_new_user.full_name)
    fill_in('Password', with: a_new_user.password)
    click_button('Register Account')
    expect(page).to have_content('Your account was created!')
  end
end
