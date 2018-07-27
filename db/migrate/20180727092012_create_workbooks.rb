class CreateWorkbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :workbooks do |t|
      t.integer :user_id
      t.string :title
      t.text :overview

      t.timestamps
    end
  end
end
