class DemandActivationsController < ApplicationController
  before_action :login_required, only: [:new, :create]

  def new
    @user = current_user
  end

  def create
    @user = User.find(params[:user][:id])
    demand_email = params[:user][:demand_email]
    @user.create_demand_digest
    if @user.update_attributes(demand_email: demand_email, demand_activated: false)
      @user.send_demand_activation_email
      # debugger
      flash[:notice] = "記入したメールアドレスに認証用のメールを送りました。"
      redirect_to edit_user_registration_url
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.demand_activated? && user.authenticated?(:demand, params[:id])
      user.demand_activate
      flash[:notice] = "認証が完了しました"
      redirect_to root_url
    else
      flash[:alert] = "認証に失敗しました"
      redirect_to root_url
    end
  end
end
