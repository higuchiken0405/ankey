class Workbook < ApplicationRecord

  validates :user_id, presence: true
  validates :title, presence: true
  validates :overview, presence: true
  belongs_to :user
end
