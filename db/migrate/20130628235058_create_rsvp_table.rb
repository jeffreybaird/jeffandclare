class CreateRsvpTable < ActiveRecord::Migration
  def up
    create_table :rsvps do |t|
      t.string  :party_name
      t.string  :number_attending
      t.integer :invitation_id
      t.string  :gift
    end
  end

  def down
    drop_table :rsvps
  end
end
