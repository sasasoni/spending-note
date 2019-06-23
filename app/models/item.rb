class Item < ApplicationRecord
  has_many :costs

  validates :item, presence: true, uniqueness: true
end
