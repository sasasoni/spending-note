class Demand < ApplicationRecord
  belongs_to :user

  validates :total_cost, presence: true, numericality:
    { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, length: { maximum: 200 }

  def self.record(user)
    total_cost = user.costs.take_demands(user).sum(:expenditure)
    user.demands.create(total_cost: total_cost, approved: false)
  end

  def approve
    update_columns(approved: true)
  end
end
