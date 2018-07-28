class QuestionAnswersController < ApplicationController

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

private
  def question_answer_params
    params.require(:question_answer).permit(:question, :answer)
  end

end
