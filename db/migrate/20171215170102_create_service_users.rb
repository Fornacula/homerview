class CreateServiceUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :service_users, id: :uuid do |t|
      t.references :service, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
