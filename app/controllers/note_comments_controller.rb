class NoteCommentsController < ApplicationController
	def create
		note = Note.find(params[:note_id])
		comment = NoteComment.new(note_comment_params)
		comment.user_id = current_user.id
		comment.note_id = note.id
		comment.save
		redirect_to note_path(note)
	end

	def destroy
		note = Note.find(params[:note_id])
		note_comment = NoteComment.find(params[:id])
		note_comment.destroy
        redirect_to note_path(note)
	end

	private
    def note_comment_params
    	params.require(:note_comment).permit(:user_id, :note_id, :comment)
    end

end
