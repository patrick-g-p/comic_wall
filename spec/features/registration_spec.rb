require 'spec_helper'

feature 'Registration' do
  let(:a_new_user) {Fabricate.build(:user)}

  scenario 'A future user inputs all their information into the register form' do
    visit('/register')
    fill_in('Email', with: a_new_user.email)
    fill_in('Full Name', with: a_new_user.full_name)
    fill_in('Password', with: a_new_user.password)
    click_button('Register Account')
    expect(page).to have_content('Your account was created!')
  end
end
