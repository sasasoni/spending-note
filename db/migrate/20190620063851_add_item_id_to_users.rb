class AddItemIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :costs, :item, foreign_key: true
  end
end
