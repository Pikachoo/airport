class CreatePassenger < ActiveRecord::Migration[5.1]
  def change
    create_table :passengers do |t|
      t.belongs_to :flight
      t.belongs_to :user
      t.timestamps
    end
  end
end
