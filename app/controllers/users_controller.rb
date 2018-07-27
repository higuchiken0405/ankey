class UsersController < ApplicationController

  # ユーザー登録画面
  def new
    @user = User.new
  end
  # ユーザー登録画面のフォームデータを処理(サインアップ)
  def create
    @user = User.new(user_params)
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
    @user = User.find_by(id: params[:id])
  end


  # ユーザー情報編集ページ表示
  def edit
    @user = User.find_by(id: params[:id])
  end
  #
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "編集が完了しました"
      redirect_to user_path(id: params[:id])
    else
      flash[:notice] = "編集に失敗しました"
      render :edit
    end
  end
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
