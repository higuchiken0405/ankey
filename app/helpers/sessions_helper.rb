module SessionsHelper
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
