class FavoritesController < ApplicationController
	def create
		note = Note.find(params[:note_id])
		favorite = Favorite.new
		favorite.user_id = current_user.id
		favorite.note_id = note.id
		favorite.save
		redirect_to note_path(note)
	end

	def destroy
		note = Note.find(params[:note_id])
		favorite = current_user.favorites.find_by(note_id: note.id)
		favorite.destroy
		redirect_to note_path(note)
	end
end
