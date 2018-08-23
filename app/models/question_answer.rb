class QuestionAnswer < ApplicationRecord
  validates :workbook_id, presence: true
  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true

  belongs_to :user
  belongs_to :workbook
  has_many :memories, dependent: :destroy
  has_many :memory_users, through: :memories, source: 'user', dependent: :destroy

  def self.import(file, workbook_id, user_id)
    CSV.foreach(file.path, headers: true) do |row|
      # QuestionAnswer省略(モデル内のメソッド)
      # id検索してあれば上書き、無ければ新規作成
      #qa = find_by_id(row["id"]) || new
      # CSVの行をハッシュ化して、内容の更新
      #qa.attributes = row.to_hash.slice(*updatable_attributes)
      #qa.save!
      qa = new(workbook_id: workbook_id, user_id: user_id)
      # CSVの行をハッシュ化して、内容の更新
      qa.attributes = row.to_hash.slice(*updatable_attributes)
      qa.save!
    end
  end
  def self.updatable_attributes
    ["user_id", "workbook_id", "question", "answer"]
  end


end
