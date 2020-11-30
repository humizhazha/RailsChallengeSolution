class Location < ApplicationRecord
  belongs_to :person
  validates :name, presence: true,
            length: { minimum: 3, maximum: 60 }
  before_save { self.name = name.titleize}

end
