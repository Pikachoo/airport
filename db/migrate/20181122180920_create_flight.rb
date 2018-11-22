class CreateFlight < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :destination_airport_code, null: false
      t.string :number, null: false
      t.integer :capacity, default: 0, null: false
      t.datetime :departure_time, null: false

      t.timestamps
    end
  end
end
