class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to The Avengers errr Comic Wall #{@user.full_name.titleize}. Your account was created!"
      redirect_to root_path
    else
      flash[:danger] = "Something went horribly wrong... like the Daredevil movie."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
