class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :notes, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notebooks, dependent: :destroy

  #フォローフォロワー機能
  acts_as_follower
  acts_as_followable

  #バリデーション
  validates :name, presence: true, length:{minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, presence: true, length:{maximum: 50}
end
