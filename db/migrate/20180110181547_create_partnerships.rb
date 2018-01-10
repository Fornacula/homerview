class CreatePartnerships < ActiveRecord::Migration[5.1]
  def change
    create_table :partnerships, id: :uuid do |t|
      t.decimal :share, default: 0
      t.references :user, foreign_key: true, type: :uuid
      t.references :community, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
