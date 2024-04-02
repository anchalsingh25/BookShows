class CreateLocationPriceEventMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :location_price_event_mappings do |t|
      t.references :event, null: false, foreign_key: true
      t.references :price, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
