# encoding: utf-8
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to user_posts_path(user.username)
    else
      flash.now[:error] = "pera que deu pêra!"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
