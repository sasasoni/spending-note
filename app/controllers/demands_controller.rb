class DemandsController < ApplicationController
  before_action :login_required

  def new
    @user = current_user
    return redirect_to new_demand_activation_url, alert: "請求先メールアドレスが設定されていません" unless @user.demand_activated
    @items = Item.all.pluck(:name)
    @costs = @user.costs.take_demands(@user).order(paid_date: :desc)
    @total_cost = @costs.sum(:expenditure)
  end

  def create
    @user = current_user
    @user.demand_mail_with_myself = params[:demand] == '1' ? true : false
    if @user.demand_email && @user.send_demand_email
      flash[:notice] = "請求メールを送りました"
      redirect_to root_url
    else
      redirect_to root_url, alert: "エラーが発生しました。"
    end
  end
end
