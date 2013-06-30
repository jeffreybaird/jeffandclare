class CreateInvitationTable < ActiveRecord::Migration
  def up
    create_table :invitations do |t|
      t.string  :party_name
      t.string  :email
      t.integer :number_invited
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :zip
    end
  end

  def down
    drop_table :invitations
  end
end
