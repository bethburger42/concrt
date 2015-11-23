class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_id
      t.date :date
      t.string :location
      t.string :artist
      t.string :price

      t.timestamps null: false
    end
  end
end
