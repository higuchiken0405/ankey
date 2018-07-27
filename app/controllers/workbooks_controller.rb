class WorkbooksController < ApplicationController
  # 問題集の作成ページ表示
  def new
    @workbook = Workbook.new
  end
  # 作成ページのフォーム情報を処理
  def create
    @workbook = current_user.workbooks.new(workbook_params)
    if @workbook.save
      flash[:sucsess] = "問題集作成に成功しました"
      redirect_to workbooks_path
    else
      flash[:notice] = "問題集作成に失敗しました"
    end
  end
  # 問題集一覧ページ表示
  def index
    @workbooks = Workbook.all
  end

  def show
    @workbook = Workbook.find_by(id: params[:id])
  end


private
  def workbook_params
    params.require(:workbook).permit(:title, :overview)
  end

end
