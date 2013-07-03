class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,            null: false
      t.string :username
      t.text :bio
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :guest, default: true

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :remember_token
  end
end
