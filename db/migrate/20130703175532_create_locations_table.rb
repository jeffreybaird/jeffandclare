class CreateLocationsTable < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.integer  :category_id
      t.string   :name
      t.string   :description
      t.integer  :link
    end
  end

  def down
    drop_table :locations
  end
end
