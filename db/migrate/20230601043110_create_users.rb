class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :email
      t.text :password
      t.text :username
      t.boolean :enabled

      t.timestamps
    end
  end
end
