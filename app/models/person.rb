class Person < ApplicationRecord
  has_many :affiliations, dependent: :destroy
  has_many :locations, dependent: :destroy
  validates :first_name, presence: true,
            length: { minimum: 3, maximum: 25 }
  validates :gender, presence: true
  before_save do
    self.gender = gender.downcase.chars.first
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
