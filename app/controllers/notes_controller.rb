class NotesController < ApplicationController

  before_action :authenticate_user!, {only: [:youtube,:new, :edit, :update, :destroy]}

  before_action :ensure_correct_user!, {only: [:edit, :update, :destroy]}

  def ensure_correct_user!
    @note = Note.find(params[:id])
    if @note.user != current_user
      redirect_to root_path
    end
  end


    #詳細ページを見た際のPV数を計測
    impressionist :actions => [:show]


 #タグ一覧の取得メソッド/使われている順に並び替え
 def tag_cloud
  @tags = Note.tag_counts_on(:tags).order('count DESC')
end

def new
    #パロメータに入っている情報を渡す
    @note = Note.new
    youtube_url = params[:note][:url]
    @video_id = youtube_url.split("=").last
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
    redirect_to note_path(@note.id)
    else
    youtube_url = params[:note][:url]
    @video_id = youtube_url
    render 'notes/new'
    end
  end

  def index
    #1ページに決められた分だけ、新しい順に取得
    @notes = Note.page(params[:page]).reverse_order
    @most_viewed = Note.order('impressions_count DESC').take(6)

    #タグ一覧の読み込み
    tag_cloud
  end

  def show
  	@note = Note.find(params[:id])
  	@note_comment = NoteComment.new
    @note_comments = @note.note_comments
    #投稿を保存するノートブックと投稿の中間テーブル
    @notebook_note = NotebookNote.new
    impressionist(@note, nil, :unique => [:session_hash])
  end

  def edit
  	@note = Note.find(params[:id])
  end

  def update
  	@note = Note.find(params[:id])
  	if @note.update(note_params)
  	redirect_to note_path(@note.id)
    else
      render 'notes/edit'
    end
  end

  def destroy
  	@note = Note.find(params[:id])
  	@note.destroy
  	redirect_to user_path(current_user.id)
  end

  def tags
    @notes = Note.tagged_with("#{params[:tag_name]}")
    @tag_name = params[:tag_name]
  end

  def search
  end

  def youtube
    #空のインスタンスを渡す
    @note = Note.new
  end

  private

  def note_params
  	params.require(:note).permit(:url, :title, :tag_list, :introduction, :body)
  end
end
