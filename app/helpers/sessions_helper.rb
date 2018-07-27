module SessionsHelper

  # 現在ログイン中のユーザーを返す
  def current_user
    @current_user ||= User.find_by(id :session[:user_id])
  end
  
end
