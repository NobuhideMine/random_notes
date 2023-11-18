# frozen_string_literal: true

# Your Ruby code goes here

class Admin::UsersController < ApplicationController
  def index
     @users = User.all.page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to admin_user_path(@user), notice: "User information updated"
     else
       render :edit
     end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end
end
