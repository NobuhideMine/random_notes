# frozen_string_literal: true

# Your Ruby code goes here

class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence:true
  validates :body, presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # いいねをつけた投稿の取得
  def self.favorited_posts(user, page, per_page) # 1. モデル内での操作を開始
    includes(:favorites) # 2. favorites テーブルを結合
      .where(favorites: { user_id: user.id }) # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
      .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
      .per(per_page) # 6. ページごとのデータ数を指定
  end

   # ransack用の検索対象フィールドを指定する
  def self.searchable_attributes
    %w[title body]
  end
  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end

  def self.ransackable_attributes(auth_object = nil)
   ["title", "body"] # 検索可能な属性名を指定
  end

  def self.ransackable_associations(auth_object = nil)
    [] # 検索可能な関連名を指定
  end
end
