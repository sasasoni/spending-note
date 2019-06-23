class Item < ApplicationRecord
  has_many :costs

  validates :name, presence: true, uniqueness: true
end
