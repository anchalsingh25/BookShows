class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :category
      t.datetime :startTime
      t.datetime :endTime
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
