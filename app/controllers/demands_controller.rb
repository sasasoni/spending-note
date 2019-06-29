class DemandsController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def index
    @user = current_user_or_guest
    @demands = @user.demands.order(created_at: :desc)
    @guest = is_guest? ? {user: @user.id, key: @user.demand_digest} : nil
  end

  def show
    @user = current_user_or_guest
    @demand = @user.demands.find(params[:id])
    @guest = is_guest? ? {user: @user.id, key: @user.demand_digest} : nil
  end

  def new
    @user = current_user
    return redirewct_to new_demand_activation_url, alert: "請求先メールアドレスが設定(有効化)されていません" unless @user.demand_activated
    @items = Item.all.pluck(:name)
    @costs = @user.costs.take_demands(@user).order(paid_date: :desc)
    @total_cost = @costs.sum(:expenditure)
  end

  def create
    @user = current_user
    @user.demand_mail_with_myself = params[:demand] == '1' ? true : false
    demand = Demand.record(@user)
    if @user.demand_email && @user.send_demand_email(demand: demand)
      flash[:notice] = "請求メールを送りました"
      redirect_to root_url
    else
      redirect_to root_url, alert: "エラーが発生しました。"
    end
  end
  
  def edit
    user = current_user_or_guest
    @demand = user.demands.find(params[:id])
    @guest = is_guest? ? {user: user.id, key: user.demand_digest} : nil
  end

  def update
    user = current_user_or_guest
    @demand = user.demands.find(params[:id])
    @guest = is_guest? ? {user: user.id, key: user.demand_digest} : nil
    if @demand.update(demand_memo_param)
      flash[:notice] = "編集しました"
      redirect_to helpers.guest_or_user_demand_path(@guest, @demand)
    else
      render :edit
    end
  end

  def approve
    user = User.find(params[:user])
    key = params[:key]
    demand = Demand.find(params[:id])
    guest = is_guest? ? {user: user.id, key: user.demand_digest} : nil
    if user.demand_digest_auth(key) && !demand.approved?
      demand.approve
      flash[:notice] = "認証しました"
      redirect_to helpers.guest_or_user_demands_path(guest)
    else
      flash[:alert] = "エラーが発生しました"
      redirect_to root_url
    end
  end

  private

  def demand_memo_param
    params.require(:demand).permit(:memo)
  end

  def current_user_or_guest
    if is_guest?
      user = User.find(params[:user])
      if user.demand_digest_auth(params[:key])
        return user
      else
        flash[:danger] = "認証に失敗しました(認証キーが古い可能性があります)"
        redirect_to root_url
      end
    else
      login_required
      current_user
    end
  end

  def is_guest?
    params[:user] && params[:key]
  end
end
