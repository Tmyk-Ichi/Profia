class Notebook < ApplicationRecord
	belongs_to :user

	#先に中間テーブルを明記すること
	has_many :notebook_notes, dependent: :destroy
	has_many :notes, through: :notebook_notes
end
