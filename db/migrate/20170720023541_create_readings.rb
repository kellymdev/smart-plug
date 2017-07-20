class CreateReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :readings do |t|
      t.datetime :date_time
      t.integer :consumption
      t.integer :temperature
      t.belongs_to :plug
      t.timestamps
    end
  end
end
