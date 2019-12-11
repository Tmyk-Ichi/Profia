class Note < ApplicationRecord
	belongs_to :user

	acts_as_taggable

	has_many :note_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	#先に中間テーブルを明記すること
	has_many :notebook_notes, dependent: :destroy
	has_many :notebooks, through: :notebook_notes

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
