class QuestionAnswersController < ApplicationController

  def index
    @workbook = Workbook.find_by(id: params[:workbook_id])
    @question_answers = @workbook.question_answers
      respond_to do |format|
        format.html
        format.csv do
          send_data render_to_string, filename: "#{@workbook.title}.csv", type: :csv
        end
      end
  end

  def import
    @workbook = Workbook.find_by(id: params[:workbook_id])
    QuestionAnswer.import(params[:file], @workbook.id, current_user.id)
    redirect_to workbook_path(@workbook)
  end


  def create
      @workbook = Workbook.find_by(id: params[:workbook_id])
      @question_answer = QuestionAnswer.new(question_answer_params)
      @question_answer.user_id = @workbook.user_id
      @question_answer.workbook_id = @workbook.id
      if @question_answer.save
       redirect_to workbook_path(@workbook)
     else
       flash.now[:danger] = "問題の登録に失敗しました"
       render "workbooks/show"
     end
  end

  def update

  end

  # 問題集削除
  def destroy
    @workbook = Workbook.find_by(id: params[:workbook_id])
    @question_answer = QuestionAnswer.find_by(id: params[:id])
    @question_answer.destroy
    redirect_to workbook_path(@workbook)
  end
private
  def question_answer_params
    params.require(:question_answer).permit(:question, :answer)
  end

end
