class CreateDemands < ActiveRecord::Migration[5.2]
  def change
    create_table :demands do |t|
      t.integer :total_cost, null: false
      t.boolean :approved, null: false, default: false
      t.text :memo
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
