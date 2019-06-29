class AddReceivedToDemands < ActiveRecord::Migration[5.2]
  def change
    add_column :demands, :received, :boolean, null: false, fafault: false
  end
end
