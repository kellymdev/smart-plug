class CreateDataFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :data_files do |t|
      t.belongs_to :plug
      t.timestamps
    end
  end
end
