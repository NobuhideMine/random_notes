# frozen_string_literal: true

# Your Ruby code goes here

class Public::RelationshipsController < ApplicationController
   
    before_action :authenticate_user!

    def create
       user = User.find(params[:user_id])
       current_user.follow(user)
       redirect_to request.referer #遷移元のURLを取得してリダイレクトする
    end

    def destroy
       user = User.find(params[:user_id])
       current_user.unfollow(user)
       redirect_to request.referer
    end

    def followings
       user = User.find(params[:user_id])
       @users = user.followings
    end

    def followers
       user = User.find(params[:user_id])
       @users = user.followers
    end
    
end
