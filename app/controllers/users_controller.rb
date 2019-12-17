class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @notes = Note.where(user_id: @user.id)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
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
