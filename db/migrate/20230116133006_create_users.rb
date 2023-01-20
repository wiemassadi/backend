class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :nom  
      t.string :prenom
      t.string :password_digest
      t.integer :role
      t.integer :balance, default: 20
      t.timestamps
    end
  end
  def self.down
    drop_table :posts
  end
end
