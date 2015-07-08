def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def clear_user_from_session
  session[:user_id] = nil
end

def login(a_user=nil)
  a_user ||= Fabricate(:user)

  visit(login_path)
  fill_in('Email', with: a_user.email)
  fill_in('Password', with: a_user.password)
  click_button("Login To Your Account")
end
