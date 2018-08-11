class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password
  validates :password, presence:true, length: { minimum: 5}

  has_many :workbooks
  has_many :question_answers
  has_many :memories
  has_many :memory_question_answers, through: :memories, source: 'question_answer'

end
