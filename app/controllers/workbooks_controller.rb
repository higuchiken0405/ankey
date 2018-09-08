class WorkbooksController < ApplicationController

  # 作成ページのフォーム情報を処理
  def create
    @workbook = current_user.workbooks.new(workbook_params)
    @workbook.user_id = current_user.id
    if @workbook.save
      flash[:sucsess] = "問題集作成に成功しました"
      redirect_to workbook_path(id: @workbook.id)
    else
      flash[:danger] = "問題集作成に失敗しました"
      redirect_to workbooks_path
    end
  end

  def edit
    @workbook = Workbook.find_by(id: params[:id])
  end

  # 問題集編集
  def update
    @workbook = Workbook.find_by(id: params[:id])
    if @workbook.update_attributes(workbook_params)
      redirect_to workbooks_path
    else
      flash[:notice] = "編集に失敗しました"
      redirect_to workbooks_path
    end
  end

  # 問題集削除
  def destroy
    @workbook = Workbook.find_by(id: params[:id])
    @workbook.destroy
    redirect_to workbooks_path
  end



  # 問題集一覧ページ表示
  def index
    # 問題集作成フォーム用のインスタンス
    @workbook = Workbook.new
    # ransckによる検索
    @search = Workbook.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(7)
  end

  # 問題集の詳細ページ表示(問題・答え一覧)
  def show
    @workbook = Workbook.find_by(id: params[:id])
    # 問題・答え作成フォーム用のインスタンス
    @question_answer = QuestionAnswer.new

    @question_answers = @workbook.question_answers.page(params[:page]).per(10)
  end


  # スライドページ表示
  def slider
    @workbook = Workbook.find_by(id: params[:id])
    # 覚えた(Memoryモデルに入っている)問答は除去する
    # 問題集の問答一覧を取得
    @question_answers = @workbook.question_answers
    # 問題があるなら
    if @question_answers.present?
      # 現在のユーザーが覚えた問答一覧を取得(現在の問題集IDの)
      @memory_question_answers = current_user.memory_question_answers.select {|qa| qa.workbook_id = params[:id]}
      # URLのクエリパラメータによって表示形式を変える(1=順列　2=ランダム)
      @display = params[:display].to_i
      if @display == 1
        # 問題集の問答　一覧から覚えた問答一覧を除外
        @workbook_question_answers = @question_answers - @memory_question_answers
      elsif @display == 2
        # 問題集の問答一覧から覚えた問答一覧を除外し、シャッフル
        @workbook_question_answers = (@question_answers - @memory_question_answers).shuffle
      else
        # URLのクエリパラメータを1か2以外で直接入力された場合
        @workbook_question_answers = @workbook.question_answers
      end
    # 問題がないなら
    else
      flash[:danger] = "問題がないので、スライド表示ができません。問題・答えを作成してください"
      redirect_to workbook_path(@workbook)
    end
  end


private
  def workbook_params
    params.require(:workbook).permit(:title, :overview)
  end

end
