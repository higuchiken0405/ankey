class Workbook < ApplicationRecord

  validates :user_id, presence: true
  validates :title, presence: true
  validates :overview, presence: true
  belongs_to :user
  has_many :question_answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: 'user', dependent: :destroy
end
