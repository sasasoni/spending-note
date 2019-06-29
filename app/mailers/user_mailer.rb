class UserMailer < ApplicationMailer
  default from: "noreply@spending-note.com"

  def demand_activation(user)
    @user = user
    mail(
      subject: "Spending-Note 請求認証確認メール",
      to: user.demand_email
    )
  end

  def demand(user, demand:)
    @user = user
    @items = Item.all.pluck(:name)
    @costs = @user.costs.take_demands(@user).order(paid_date: :desc)
    @total_cost = @costs.sum(:expenditure)
    @demand = demand
    send_address = if @user.demand_mail_with_myself
      "#{@user.demand_email}, #{@user.email}"
    else
      @user.demand_email
    end
    mail(
      subject: "Spending-Note 請求メール",
      to: send_address
    )
  end

end
