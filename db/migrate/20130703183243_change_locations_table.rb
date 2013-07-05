class ChangeLocationsTable < ActiveRecord::Migration
  def up
    change_column(:locations, :description, :text)
  end

  def down
  end
end
