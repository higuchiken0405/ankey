

CSV.generate do |csv|
  column_names = %w(question answer)
  csv << column_names
  @question_answers.each do |qa|
    column_values = [
      qa.question,
      qa.answer
    ]
    csv << column_values
  end
end
