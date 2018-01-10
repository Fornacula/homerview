class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
      t.references :user, foreign_key: true, type: :uuid
    end
  end
end
