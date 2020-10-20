class ChangePersonIdColumnInAffiliation < ActiveRecord::Migration[6.0]
  def change
    rename_column(:affiliations,:personId,:person_id)
  end
end
