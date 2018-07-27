class SessionsController < ApplicationController

  # ログイン画面表示
  def new
  end

  # ログイン画面で入力したフォームの情報を受け取り処理
  def create
    user = User.find_by(email: params[:session][:enamil])
    if user && user.authenticate(params[:session][:password])
        log_in(user)
        redirect_to root_path
    else
      # エラーメッセージ
      render :new
    end
  end

  # ログアウト
  def destroy
    log_out
    redirect_to root_url
  end


private
  #フォーム情報から検索したユーザーのIDをセッションIDに
  def log_in(user)
    session[:user_id] = user.id
  end
  # ユーザーIDを削除し、current_user(現在のユーザー)ｲﾝｽﾀﾝｽを空に
  def log_out
    session.delete(:user_id)    # セッションに保存されているuser_idを削除
    @current_user = nil         # ユーザー情報を削除
  end
end
