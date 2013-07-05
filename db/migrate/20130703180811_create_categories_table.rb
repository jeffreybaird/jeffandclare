class CreateCategoriesTable < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string   :name
      t.string   :subtitle
    end
  end

  def down
    drop_table :categories
  end
end
