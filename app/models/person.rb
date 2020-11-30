class Person < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: [[:first_name],[:last_name],[:weapon],[:vehicle],[:gender],[:species]],
                  using: {tsearch: {prefix: true, dictionary: "english"}}

  has_enumeration_for :gender
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

  def full_gender
    if self.gender == 'm'
      Gender::MALE
    elsif self.gender == 'f'
      Gender::FEMALE
    else
      Gender::OTHER
    end
  end
end
