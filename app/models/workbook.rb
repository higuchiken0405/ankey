class Workbook < ApplicationRecord

  validates :user_id, presence: true
  validates :title, presence: true
  validates :overview, presence: true
  belongs_to :user
  has_many :question_answers
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
end
