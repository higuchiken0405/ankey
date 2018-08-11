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
    # 問題集作成フォーム用のインスタンス
    @workbook = Workbook.new
    # 問題集一覧表示のため、全ての要素を取得し、代入
    @workbooks = Workbook.all
    # ransckによる検索
    @search = Workbook.ransack(params[:q])
    @result = @search.result
  end

  # 問題集の詳細ページ表示
  def show
    @workbook = Workbook.find_by(id: params[:id])
    # 問題・答え作成フォーム用のインスタンス
    @question_answer = QuestionAnswer.new

    @question_answers = @workbook.question_answers
    @memory_question_answers = current_user.memory_question_answers.select {|qa1| qa1.workbook_id = params[:id]}
    @qa = @question_answers - @memory_question_answers
  end
  # スライドページ表示
  def slider
    @workbook = Workbook.find_by(id: params[:id])

    @display = params[:display].to_i

    # 覚えた(Memoryモデルに入っている)問答は除去する
    # 問題集の問答一覧を取得
    @question_answers = @workbook.question_answers
    # 現在のユーザーが覚えた問答一覧を取得
    @memory_question_answers = current_user.memory_question_answers.select {|qa1| qa1.workbook_id = params[:id]}
    # URLのクエリパラメータによって表示形式を変える(1=順列　2=ランダム)
    @display = params[:display].to_i
    if @display == 1
      # 問題集の問答一覧から覚えた問答一覧を除外
      @workbook_question_answers = @question_answers - @memory_question_answers
   elsif @display == 2
      # 問題集の問答一覧から覚えた問答一覧を除外し、シャッフル
     @workbook_question_answers = (@question_answers - @memory_question_answers).shuffle
   else
     # URLのクエリパラメータを1か2以外で直接入力された場合
     @workbook_question_answers = @workbook.question_answers
   end
  end

private
  def workbook_params
    params.require(:workbook).permit(:title, :overview)
  end

end
