class Public::PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @post = Post.new
    @posts = Post.all.order(params[:sort])
  end
  
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def create
    @post = Post.new(book_params)
    @post.user_id = current_user.id
    
    if @post.save
      
    redirect_to post_path(@post), notice: "You have created book successfully." 
    else
    @posts = Post.all
    render 'index'
    end
  end

  def edit
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully." 
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end


  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
    redirect_to posts_path
    end
  end
  
end
