class ChangeDatatypeQuestionOfQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    #[形式] change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :question_answers, :question, :text
  end
end
