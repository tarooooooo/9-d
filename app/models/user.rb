class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book

  has_many :active_relationships, class_name: "Relationship", foreign_key: :followed_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship",foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :followed

  has_many :group_users
  has_many :groups , through: :group_users
  
  attachment :profile_image

  validates :name, presence: true, length: {minimum: 2,maximum: 20} , uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def liked_by?(book_id)
    self.favorites.where(book_id: book_id).exists?
  end

  def followed_by?(user)
     active_relationships.find_by(follower_id: user.id).present?
  end

  def self.looks(searches, word)
    if searches == "perfect_match"
      @user = User.where( "name LIKE ?" , "#{word}" )
    elsif searches == "forword_match"
      @user = User.where("name LIKE ?" , "%#{word}")
    elsif searches == "backword_match"
      @user = User.where("name LIKE ?" , "#{word}%")
    else
      @user = User.where("name LIKE ?" , "%#{word}%" )
    end
  end

end