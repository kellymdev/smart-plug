class CreatePlugs < ActiveRecord::Migration[5.0]
  def change
    create_table :plugs do |t|
      t.string :name
      t.string :login_user
      t.string :login_password
      t.string :ip_address
      t.timestamps
    end
  end
end
