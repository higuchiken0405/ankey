class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "登録完了しました"
      redirect_to root_path
    else
      flash.now[:notice] = "登録に失敗しました"
      render "new"
    end
  end


private
  def users_params
    params.require(:user).permit(:name, :email)
  end

end
