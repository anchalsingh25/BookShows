class CreateBookingItems < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_items do |t|
      t.references :event, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
