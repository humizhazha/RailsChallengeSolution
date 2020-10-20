class ChangePersonIdColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column(:locations,:personId,:person_id)
  end
end
