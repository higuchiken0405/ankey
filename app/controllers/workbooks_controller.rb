class WorkbooksController < ApplicationController
  # 問題集の作成ページ表示
  def new
    @workbook = Workbook.new
  end
  # 作成ページのフォーム情報を処理
  def create
    @workbook = current_user.workbooks.new(workbook_params)
    @workbook.user_id = current_user.id
    if @workbook.save
      flash[:sucsess] = "問題集作成に成功しました"
      redirect_to workbook_path(id: @workbook.id)
    else
      flash[:danger] = "問題集作成に失敗しました"
    end
  end
  # 問題集一覧ページ表示
  def index
    @workbook = Workbook.new
    @workbooks = Workbook.all
  end
  # 問題集の詳細ページ表示
  def show
    @workbook = Workbook.find_by(id: params[:id])
    @question_answer = QuestionAnswer.new
  end
  # スライドページ表示
  def slider
    @workbook = Workbook.find_by(id: params[:id])
    @question_answer = QuestionAnswer.new
  end

private
  def workbook_params
    params.require(:workbook).permit(:title, :overview)
  end

end
