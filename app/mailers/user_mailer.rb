class UserMailer < ApplicationMailer
  default from: "spending-note@mail.com"

  def demand_activation(user)
    @user = user
    mail(
      subject: "請求認証確認メール",
      to: user.demand_email,
      from: "spending-note@mail.com"
    )
  end
end
