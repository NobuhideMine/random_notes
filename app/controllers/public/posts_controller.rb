# frozen_string_literal: true

# Your Ruby code goes here

class Public::PostsController < ApplicationController
  
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
        @post = Post.new

        @q = Post.ransack(params[:q])
        
        if params[:q].present?
            @posts = @q.result(distinct: true).page(params[:page]).per(8)
        else
            @posts = Post.order(created_at: :desc).page(params[:page]).per(8)
        end
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
        @user = @post.user
        @post_comment = PostComment.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id

        if @post.save
            redirect_to post_path(@post), notice: "You have created post successfully."
        else
            render "new"
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post.id), notice: "You have updated post successfully."
        else
            render "edit"
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "our post has been deleted."
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end


    def ensure_correct_user
        @post = Post.find(params[:id])
        unless @post.user == current_user
        redirect_to posts_path
        end
    end
    
end
