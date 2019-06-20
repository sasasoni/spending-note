class RenameCostsName < ActiveRecord::Migration[5.2]
  def up
    rename_column :items, :name, :item_name
  end

  def down
    rename_column :items, :item_name, :name
  end
end
