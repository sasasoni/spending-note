class UserMailer < ApplicationMailer
  default from: "spending-note@mail.com"

  def demand_activation(user)
    @user = user
    mail(
      subject: "Spending-Note 請求認証確認メール",
      to: user.demand_email,
      from: "spending-note@mail.com"
    )
  end

  def demand(user)
    @user = user
    @items = Item.all.pluck(:name)
    @costs = @user.costs.take_demands(@user).order(paid_date: :desc)
    @total_cost = @costs.sum(:expenditure)
    send_address = if @user.demand_mail_with_myself
      "#{@user.demand_email}, #{@user.email}"
    else
      @user.demand_email
    end
    mail(
      subject: "Spending-Note 請求メール",
      to: send_address,
      from: "spending-note@mail.com"
    )
  end

end
