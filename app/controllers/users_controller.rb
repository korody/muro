# encoding: utf-8
class UsersController < ApplicationController
  
  def index
    @users = User.all(order: :name)
  end

  def show
    @user = User.where(username: params[:username]).first
    @posts = @user.posts.order('posts.created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_posts_path(@user.username)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if @user.email_changed? && @user.password_digest_changed?
      @user.update_attributes(guest: 'FALSE')
    end
    if @user.update_attributes user_params
      sign_in @user
      redirect_to user_posts_path(@user.username)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :username, :guest, :bio)
  end

end
