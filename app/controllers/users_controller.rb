class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: user_params[:username], password: user_params[:password])
    if user_params[:password] == user_params[:confirm_password]
      if @user.save
        session[:user_id] = @user.id
        redirect_to '/'
      else
        @errors = @user.errors.full_messages
        render 'new'
      end
    else
      @errors = ["Passwords don't match.", "I have no way of resetting this so make sure you get it right.", "Maybe write it down, too."]
      render 'new'
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
      params.require(:user).permit(:username, :password, :confirm_password)
    end

end
