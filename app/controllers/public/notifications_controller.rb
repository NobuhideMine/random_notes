# frozen_string_literal: true

# Your Ruby code goes here

class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
