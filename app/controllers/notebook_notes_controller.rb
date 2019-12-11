class NotebookNotesController < ApplicationController
	def create
		notebook_note = NotebookNote.new(notebook_note_params)
		notebook_note.save
		redirect_to note_path(notebook_note.note.id)
	end

	def destroy
		notebook_note = NotebookNote.find(params[:id])
		notebook = Notebook.find_by(id: notebook_note.notebook_id)
		notebook_note.destroy
		redirect_to notebook_path(notebook.id)
	end

	private
	def notebook_note_params
		params.require(:notebook_note).permit(:notebook_id, :note_id)
	end
end
