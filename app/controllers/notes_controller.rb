class NotesController < ApplicationController
	def new
		@note = Note.new
	end

	def create
		@note = Note.new(note_params)
		@note.user_id = current_user.id
	    @note.save
	    redirect_to note_path(@note.id)
	end

	def index
		@notes = Note.all
	end

	def show
		@note = Note.find(params[:id])
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		note = Note.find(params[:id])
		note.update(note_params)
		redirect_to note_path(note.id)
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to mypage_path(current_user.id)
	end

	private

	def note_params
		params.require(:note).permit(:url, :title, :tag_list, :introduction, :body)
	end
end
