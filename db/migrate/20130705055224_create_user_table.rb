class CreateUserTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string   :user_name
      t.string   :password
    end
  end

  def down
    drop_table :users
  end
end
