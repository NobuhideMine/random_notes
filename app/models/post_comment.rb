# frozen_string_literal: true

# Your Ruby code goes here

class PostComment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :comment, presence:true
    
    has_one :notification, as: :subject, dependent: :destroy

    after_create_commit :create_notifications

    private
    
    def create_notifications
        Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post)
    end
end
