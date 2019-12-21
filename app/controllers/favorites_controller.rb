class FavoritesController < ApplicationController
	def create
		@favorite = current_user.favorites.create(note_id: params[:note_id])
		@note = Note.find(params[:note_id])
		render 'index.js.erb'
	end

	def destroy
		@note = Note.find(params[:note_id])
		@favorite = current_user.favorites.find_by(note_id: params[:note_id]).destroy
		render 'index.js.erb'
	end
end
