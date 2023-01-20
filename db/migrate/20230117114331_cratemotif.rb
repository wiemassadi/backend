class Cratemotif < ActiveRecord::Migration[7.0]
  def change
    create_table :motifs do |t|
      t.string :raison
      t.timestamps
    end
  end
end
