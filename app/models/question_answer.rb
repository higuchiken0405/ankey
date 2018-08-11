class QuestionAnswer < ApplicationRecord
  validates :workbook_id, presence: true
  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true

  belongs_to :user
  belongs_to :workbook
  has_many :memories
  has_many :memory_users, through: :memories, source: 'user' 
end
