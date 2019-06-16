class CostsController < ApplicationController
  def index
    @costs = current_user.costs.latest
  end

  def show
    @cost = Cost.find(params[:id])
  end

  def new
    @cost = Cost.new
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

  private

  def cost_params
    params.require(:cost).permit(
      :name,
      :expenditure,
      :paid_date,
      :demand
    )
  end
end
