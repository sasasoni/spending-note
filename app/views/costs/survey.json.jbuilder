# item_names = Item.all
# total_costs = []
# item_names.each do |item|
#   total_costs << @costs.where(item_id: item.id).sum(:expenditure)
# end
# json.item_names item_names.pluck(:name) # ["食費", "趣味", "本", "その他"]
# json.costs total_costs # [3400, 1200, 3500, 1500]

total_costs = @costs.joins(:item).group('items.name').sum(:expenditure)
json.item_names total_costs.keys # ["食費", "趣味", "本", "その他"]
json.costs total_costs.values # [3400, 1200, 3500, 1500]