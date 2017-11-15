class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @errors = ['Either your username or password was incorrect.']
      redirect_to '/login'
    end
  end

  def destroy
    status 204
    session[:user_id] = nil
    redirect_to '/login'
  end
end