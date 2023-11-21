# frozen_string_literal: true

# Your Ruby code goes here

class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :post

    has_one :notification, as: :subject, dependent: :destroy

    after_create_commit :create_notifications

  private
  def create_notifications
    Notification.create(subject: self, user: self.post.user, action_type: :favorited_to_own_post)
  end
end
