class NotebookNote < ApplicationRecord
	belongs_to :notebook
	belongs_to :note
end
