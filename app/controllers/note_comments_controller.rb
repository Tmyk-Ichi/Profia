class NoteCommentsController < ApplicationController
	#form_withで送られてきた場合、アクション名と同じjs.erbが呼び出される
	def create
		@note = Note.find(params[:note_id])
		#note_idを含んだ形でインスタンスを形成
		@note_comment = @note.note_comments.build(note_comment_params)
		@note_comment.user_id = current_user.id
		#保存されたら、jsファイルを探しに行く
		if @note_comment.save
			@note_comments = @note.note_comments
		end
	end

	def destroy
		@note = Note.find(params[:note_id])
		@note_comment = NoteComment.find(params[:id])
		@note_comment_id = @note_comment.id
		if @note_comment.destroy
			@note_comments = @note.note_comments
			@msg ="削除が成功しました"
		end
	end

	private
    def note_comment_params
    	params.require(:note_comment).permit(:user_id, :note_id, :comment)
    end

end
