class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @errors = @user.errors.full_messages
      render '/users/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.order(:username)
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
