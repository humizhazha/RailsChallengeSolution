class Location < ApplicationRecord
  belongs_to :person
  before_save { self.name = name.titleize}
end
