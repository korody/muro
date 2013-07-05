# encoding: utf-8
class PostsController < ApplicationController
  # before_action :authenticate, only: [:edit, :update, :create]

  def index
    @posts = Post.all.order('posts.created_at DESC').limit(20)
    @new_post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    if signed_in?
      @new_post = current_user.posts.build(post_params)
      if @new_post.save
        flash.now[:success] = "Você passou adiante #{current_user.name}! O mundo é um lugar melhor."
        redirect_to root_path
      else
        render 'edit'
      end
    else
      @new_post = Post.create(post_params)
      some_user = User.where(name: @new_post.from_user).first_or_create!
      if @new_post.valid?
        if some_user.guest?
          sign_in(some_user)
          redirect_to root_path
        else
          redirect_to signin_path, notice: "Olá #{some_user.name}! É você mesmo?"
        end
        @new_post.assign_user
        @new_post.save
      else
        render 'edit'
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes! post_params
    redirect_to @post
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :from_user)
  end

end
