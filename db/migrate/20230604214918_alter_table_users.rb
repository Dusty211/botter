class AlterTableUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension("citext")
    change_column :users, :email, :citext
    change_column :users, :username, :citext
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
