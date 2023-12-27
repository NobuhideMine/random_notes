# frozen_string_literal: true

# Your Ruby code goes here

class Public::PostCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:destroy]
    
    def create
        post = Post.find(params[:post_id])
        @comment = current_user.post_comments.new(post_comment_params)
        @comment.post_id = post.id
        @comment.save
    end

    def destroy
        @comment = PostComment.find(params[:id])
        
        if  @comment.user == current_user
            @comment.destroy
        else
            # 他のユーザーのコメントを削除しようとした場合の処理
            flash[:alert] = "You don't have permission to delete this comment."
        end   
    end

    private
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
    
    def set_comment
        @comment = PostComment.find(params[:id])
    end
    
end
