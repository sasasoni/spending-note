class CostsController < ApplicationController
  before_action :login_required

  def index
    @items = Item.all.pluck(:name)
    @q = current_user.costs.ransack(params[:q])
    @costs = @q.result(distinct: true).page(params[:page]).per(20)
    # @costs = current_user.costs.latest.joins(:item).select('costs.*, items.name AS item_name')
  end

  def show
    @cost = Cost.find(params[:id])
  end

  def new
    @cost = Cost.new
    # [["食費", "1"],["趣味", "2"]]
    # @items = Item.all.pluck(:name, :id)
  end

  def create
    @cost = current_user.costs.build(cost_params)
    if @cost.save
      flash[:notice] = "#{@cost.name}を登録しました"
      redirect_to costs_url
    else
      render :new
    end
  end

  def edit
    @cost = current_user.costs.find(params[:id])
  end

  def update
    @cost = current_user.costs.find(params[:id])
    if @cost.update!(cost_params)
      flash[:notice] = "#{@cost.name}を編集しました"
      redirect_to costs_url
    else
      render :edit
    end
  end

  def destroy
    @cost = current_user.costs.find(params[:id])
    @cost.destroy
    flash[:notice] = "#{@cost.name}を削除しました"
    redirect_to costs_url
  end

  def survey
    # 5/25/00:00~6/24/23:59は6月分として集計したい(現在は違う仕様にしてる)
    # request=>costs/survey?year=2019&month=6
    @year = params[:year] || Time.current.year
    @month = params[:month] || Time.current.month
    @date = Time.zone.local(@year, @month)
    # begin
    #   @date = Time.zone.local(params[:year], params[:month])
    # rescue
    #   return redirect_to root_path
    # end
    # begin
    #   raw_date = Time.parse(params[:date])
    # rescue
    #   return redirect_to root_path
    # end
    # # 取り出した日がその月の25日以降か? 翌月 : 今月
    # @date = raw_date >= raw_date.beginning_of_month.advance(days: 24) ? raw_date.next_month : raw_date
    @q = current_user.costs.period(@date).ransack(params[:q])
    @costs = @q.result(distinct: true)
    @total_cost = @costs.sum(:expenditure)
    @total_private_cost = @costs.where(demand: false).sum(:expenditure)
    @items = Item.all.pluck(:name)
    @costs_page = @costs.page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def cost_params
    params.require(:cost).permit(
      :name,
      :expenditure,
      :paid_date,
      :demand,
      :item_id,
      :memo
    )
  end

  # application.rbに移行
  # def login_required
  #   redirect_to new_user_session_path, notice: "ログインしてください" unless current_user
  # end
end
