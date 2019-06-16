class CreateCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :costs do |t|
      t.string :name, null: false
      t.integer :expenditure, null: false
      t.date :paid_date, null: false
      t.boolean :demand, null: false, fefault: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :costs, :paid_date
  end
end
