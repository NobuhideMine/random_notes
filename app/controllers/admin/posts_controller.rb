# frozen_string_literal: true

# Your Ruby code goes here

class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
