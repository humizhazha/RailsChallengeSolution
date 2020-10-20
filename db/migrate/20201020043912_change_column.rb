class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:people, :first_name, false )
  end
end
