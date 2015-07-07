class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are vengance. You are the night. You. Are. Logged in."
      redirect_to root_path
    else
      flash[:danger] = 'Something was wrong with either your email or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've logged out. Thanks for using Comic Wall!"
    redirect_to root_path
  end
end
