class AddUserIdToQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :question_answers, :user_id, :integer, after: :workbook_id
  end
end
