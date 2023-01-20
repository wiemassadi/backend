class Updatedemandes < ActiveRecord::Migration[7.0]
def change
  add_column :demandes, :employe_id, :integer
  add_index  :demandes, :employe_id
  add_column :demandes, :motif_id, :integer
  add_index  :demandes, :motif_id
  add_index  :demandes, :start_date
  add_index  :demandes, :end_date
 
end
end