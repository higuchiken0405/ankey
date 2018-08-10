class MemoriesController < ApplicationController



  def create
    memory = Memory.new
    memory.user_id = current_user.id
    memory.question_answer_id = params[:question_answer_id]
    if memory.save
      redirect_to workbook_path(id: params[:workbook_id])
    else
      flash[:danger] = "失敗しました"
      redirect_to workbook_path(id: params[:workbook_id])
    end
  end
end
