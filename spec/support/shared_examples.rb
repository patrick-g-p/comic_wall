shared_examples 'login_is_required' do
  it 'redirects to the login page' do
    clear_user_from_session
    action
    expect(response).to redirect_to login_path
  end
end
