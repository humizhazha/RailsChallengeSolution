class AddGenderSpeciesToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :gender, :string
    add_column :people, :species, :string
  end
end
