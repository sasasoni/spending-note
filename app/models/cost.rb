class Cost < ApplicationRecord
  belongs_to :user
  belongs_to :item # NOT NULLが自動で付く

  validates :user_id, presence: true
  validates :name, presence: true
  validates :expenditure, presence: true, numericality:
    { only_integer: true, greater_than_or_equal_to: 0 }
  validates :paid_date, presence: true
  validates :demand, inclusion: { in: [true, false] }
  validates :memo, length: { maximum: 200 }

  scope :latest, -> { order(created_at: :desc) }
  scope :period, -> (date) do
    # start_date = 先月の25日00:00:00
    start_date = date.last_month.beginning_of_month.advance(days: 24)
    # end_date = 今月の24日23:59:59
    end_date = date.beginning_of_month.advance(days: 23).end_of_day

    # 支払い日が指定した期間内にあるものを取り出す
    where("paid_date >= ? AND paid_date  <= ?", start_date, end_date)
    # where(Cost.arel_table[:paid_date].gteq(start_date).and(Cost.arel_table[:paid_date].lteq(end_date)))
  end
  scope :take_demands, -> (user) do
    if user.demanded_at.nil?
      where(demand: true)
    else
      where(demand: true).where("created_at >= ? AND created_at <= ?", user.demanded_at, Time.current)
    end
  end
end
