class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to The Avengers errr Comic Wall #{@user.full_name.titleize}. Your account was created!"
      redirect_to root_path
    else
      flash[:danger] = "Something went horribly wrong... like the Daredevil movie."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # @discussions_contributed_to = Discussion.joins(:replies).where(user_id: params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Sorry, that user doesn't exist!"
      redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
