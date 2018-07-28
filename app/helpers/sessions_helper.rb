module SessionsHelper

  #フォーム情報から検索したユーザーのIDをセッションIDに
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  # 現在ログイン中か
  def logged_in?
    !current_user.nil?
  end

  #
  def current_user?(user)
    user == current_user
  end
end
