class CreatePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :periods do |t|
      t.references :invoice, index: true
      t.string :length
      t.date :period_start
      t.date :period_end
      t.boolean :single, default: false
      t.timestamps
    end
  end
end
