class Createdemandes < ActiveRecord::Migration[7.0]
  def change
    create_table :demandes do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status ,  default: 0
      t.integer :nb_rdays
      t.string :commentaire
    end
  end
end
