class ChangeColumnInLocations < ActiveRecord::Migration
  def up
    change_column(:locations, :link, :string)
  end

  def down
  end
end
