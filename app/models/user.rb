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
  
  
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
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
end