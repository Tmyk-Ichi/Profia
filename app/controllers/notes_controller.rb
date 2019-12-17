class NotesController < ApplicationController
    #詳細ページを見た際のPV数を計測
    impressionist :actions => [:show]
  def new
    	@note = Note.new
  end

  def create
    	@note = Note.new(note_params)
	#youtube URLの切り出し
	youtube_url = params[:note][:url]
	youtube_url = youtube_url.last(11)
	@note.url = youtube_url
      #切り出し終了
      @note.user_id = current_user.id
      @note.save
      redirect_to note_path(@note.id)
  end

  def index
  	@notes = Note.all
  	@most_viewed = Note.order('impressions_count DESC').take(6)
  end

  def show
  	@note = Note.find(params[:id])
  	@note_comment = NoteComment.new
  	@notebook_note = NotebookNote.new
  	impressionist(@note, nil, :unique => [:session_hash])
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

  def result
  end

  private

  def note_params
  	params.require(:note).permit(:url, :title, :tag_list, :introduction, :body)
  end
end
