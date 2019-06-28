class Demand < ApplicationRecord
  belongs_to :user

  validates :total_cost, presence: true, numericality:
    { only_integer: true, greater_than_or_equal_to: 0 }
  validates :approved, inclusion: { in: [true, false] }
  validates :memo, length: { maximum: 200 }
end
