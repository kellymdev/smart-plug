class CreateReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :readings do |t|
      t.datetime :date_time
      t.integer :consumption
      t.integer :temperature
      t.timestamps
    end
  end
end
