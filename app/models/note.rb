class Note < ApplicationRecord
	belongs_to :user

    acts_as_taggable_on :labels
	acts_as_taggable

	has_many :note_comments, dependent: :destroy

	has_many :favorites, dependent: :destroy
	#先に中間テーブルを明記すること
	has_many :notebook_notes, dependent: :destroy
	has_many :notebooks, through: :notebook_notes

	is_impressionable counter_cache: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	#バリテーション
	validates :title, presence: true, length:{minimum: 2, maximum: 20}
	validates :introduction, presence: true, length:{maximum: 50}
	validates :body, presence: true, length:{maximum: 200}

	#公開非公開の設定
	#enum status:{nonreleased: 0, released: 1}
end
