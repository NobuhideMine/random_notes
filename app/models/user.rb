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
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
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
