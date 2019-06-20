class AddMemoToCosts < ActiveRecord::Migration[5.2]
  def change
    add_column :costs, :memo, :string
  end
end
