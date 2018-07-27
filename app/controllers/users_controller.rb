class UsersController < ApplicationController

  # ユーザー登録画面
  def new
    @user = User.new
  end
  # ユーザー登録画面のフォームデータを処理(サインアップ)
  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "登録完了しました"
      redirect_to users_path
    else
      flash.now[:notice] = "登録に失敗しました"
      render :new
    end
  end
  # ユーザー情報を一覧表示
  def index
    @users = User.all
  end
  # ユーザー情報ページ表示
  def show

  end


private
  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
