class Demande < ApplicationRecord
    belongs_to :employe, class_name: 'Employe', foreign_key: 'employe_id', optional: true
    belongs_to :motif
    enum status: %i[encours accepter refuse]
end