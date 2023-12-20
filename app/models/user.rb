# frozen_string_literal: true

# Your Ruby code goes here

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_one_attached :profile_image

    has_many :posts, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy

  #フォローされる
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #自分をフォローしている人
    has_many :followers, through: :reverse_of_relationships, source: :follower

  #フォローする
    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #自分がフォローしている人
    has_many :followings, through: :relationships, source: :followed
  #通知機能
    has_many :notifications, dependent: :destroy

    def get_profile_image(width, height)
        unless profile_image.attached?
            file_path = Rails.root.join("app/assets/images/no_image.jpg")
            profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
        end
        profile_image.variant(resize_to_limit: [width, height]).processed
    end

    def follow(user)
        relationships.create(followed_id: user.id) #フォローしたとき
    end

    def unfollow(user)
        relationships.find_by(followed_id: user.id).destroy #フォローを外したとき
    end

    def following?(user)
        followings.include?(user)
    end
    
    GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
        find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
            user.password = SecureRandom.urlsafe_base64
            user.name = "guestuser"
        end
    end

    def guest_user?
        email == GUEST_USER_EMAIL
    end

  # ransack用の検索対象フィールドを指定する
    def self.searchable_attributes
        %w[name]
    end
    
    searchable_attributes.each do |field|
        scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
    end

    def self.ransackable_attributes(auth_object = nil)
        ["name"] # 検索可能な属性名を指定
    end

    def self.ransackable_associations(auth_object = nil)
        [] # 検索可能な関連名を指定
    end

    validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
    validates :introduction, length: { maximum: 50 }

end