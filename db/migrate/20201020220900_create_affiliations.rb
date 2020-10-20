class CreateAffiliations < ActiveRecord::Migration[6.0]
  def change
    create_table :affiliations do |t|
      t.string :name
      t.integer :personId
      t.timestamps
    end
  end
end
