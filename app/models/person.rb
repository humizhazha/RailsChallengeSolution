class Person < ApplicationRecord
  has_many :affiliations, dependent: :destroy
  has_many :locations, dependent: :destroy
  validates :first_name, presence: true
end
