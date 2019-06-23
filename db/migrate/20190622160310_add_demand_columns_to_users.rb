class AddDemandColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :demand_email, :string
    add_column :users, :demanded_at, :datetime
    add_column :users, :demand_digest, :string
    add_column :users, :demand_activated, :boolean, default: false
    add_index :users, :demanded_at
  end
end
