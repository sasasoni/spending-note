class DemandsController < ApplicationController
  before_action :login_required

  def new
    @user = current_user
    @items = Item.all.pluck(:name)
    @costs = @user.costs.take_demands(@user).order(paid_date: :desc)
    @total_cost = @costs.sum(:expenditure)
  end

  def create
    @user = current_user
    @user.demand_mail_with_myself = params[:demand] == '1' ? true : false
    if @user.send_demand_email
      flash[:notice] = "請求メールを送りました"
      redirect_to root_url
    end
  end
end
