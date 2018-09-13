class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password
  validates :password, presence:true, length: { minimum: 5}

  mount_uploader :image, ImageUploader

  has_many :workbooks, dependent: :destroy
  has_many :question_answers, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memory_question_answers, through: :memories, source: 'question_answer'
  has_many :favorites, dependent: :destroy
  has_many :favorite_workbooks, through: :favorites, source: 'workbook'
  has_many :events, dependent: :destroy

end
