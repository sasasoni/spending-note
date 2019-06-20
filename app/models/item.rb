class Item < ApplicationRecord
  has_many :costs

  validates :item_name, presence: true, uniqueness: true
end
