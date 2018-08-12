class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # ユーザー登録画面
  def new
    @user = User.new
  end
  # ユーザー登録画面のフォームデータを処理(サインアップ)
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "登録完了しました"
      redirect_to user_path(id: @user.id)
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  # ユーザー情報を一覧表示
  def index
    @users = User.all
  end
  # ユーザー情報ページ表示
  def show
    # ユーザー情報の取得
    @user = User.find_by(id: params[:id])
    # 問題集作成フォーム用のインスタンス
    @workbook = Workbook.new
    # 問題集一覧を取得
    @workbooks = Workbook.all
    # お気に入りの問題集一覧を取得
    @favorite_workbooks = @user.favorite_workbooks
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

  # beforeフィルター

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  #正しいユーザーかどうか確認
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(user_path(id: current_user.id)) unless current_user?(@user)
  end

end
