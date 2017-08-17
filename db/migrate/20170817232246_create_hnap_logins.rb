class CreateHnapLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :hnap_logins do |t|
      t.belongs_to :plug
      t.string :login_result
      t.string :challenge
      t.string :public_key
      t.string :cookie
      t.timestamps
    end
  end
end
