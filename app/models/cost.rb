class Cost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :expenditure, presence: true, numericality:
    { only_integer: true, greater_than_or_equal_to: 0 }
  validates :paid_date, presence: true
  validates :demand, inclusion: { in: [true, false] }

  scope :latest, -> { order(created_at: :desc) }
end
