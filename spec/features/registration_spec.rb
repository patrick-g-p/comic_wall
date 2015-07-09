require 'spec_helper'

feature 'Registration' do
  let(:a_new_user) {Fabricate.build(:user)}

  scenario 'A future user inputs all their information into the register form' do
    go_to_registration_page
    fill_out_registraion_info
    account_creation_confirmed
  end

  def go_to_registration_page
    visit('/register')
  end

  def fill_out_registraion_info
    fill_in('Email', with: a_new_user.email)
    fill_in('Full Name', with: a_new_user.full_name)
    fill_in('Password', with: a_new_user.password)
    click_button('Register Account')
  end

  def account_creation_confirmed
    expect(page).to have_content('Your account was created!')
  end
end
