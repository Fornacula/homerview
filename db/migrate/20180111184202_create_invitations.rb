class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations, id: :uuid do |t|
      t.decimal :share
      t.string :email
      t.references :community, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
