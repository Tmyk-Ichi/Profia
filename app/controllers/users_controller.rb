class UsersController < ApplicationController
  before_action :authenticate_user!, {only: [:edit,:update]}
  before_action :ensure_correct_user, {only: [:edit,:update]}

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    end
  end

  def show
  	@user = User.find(params[:id])
    #フォローを定義
    @follows = @user.all_following
    #フォロワーを定義
    @followers = @user.followers
    #ユーザーのお気に入りを取得
    #ユーザーに紐づいているfavoriteのノートIDを配列化
    favorite_ids = @user.favorites.pluck(:note_id)
    @favorite_notes = Note.where(id: favorite_ids).page(params[:page]).reverse_order
    #ユーザーの投稿を取得
    @notes = Note.where(user_id: @user.id).page(params[:page]).reverse_order
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	redirect_to user_path(@user.id)
    else
    render 'users/edit'
    end
  end

  def follow
    @user = User.find(params[:id])
    #ログイン中のユーザーで対象のユーザー(@user)をフォローする
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    #ログイン中のユーザーで対象のユーザー(@user)をフォロー解除する
    current_user.stop_following(@user)
    redirect_to user_path(@user)
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
