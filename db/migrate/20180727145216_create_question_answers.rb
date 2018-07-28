class CreateQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :question_answers do |t|
      t.integer :workbook_id
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
