class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.workbook_id = params[:workbook_id]
    if favorite.save
      redirect_to workbooks_path
    else
      flash[:danger] = "失敗しました"
      redirect_to workbooks_path
    end
  end

  def destroy
    @favorite = Favorite.find_by(workbook_id: params[:workbook_id])
    @favorite.delete
    redirect_to workbooks_path
  end

end
