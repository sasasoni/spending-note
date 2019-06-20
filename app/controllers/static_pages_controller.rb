class StaticPagesController < ApplicationController
  def home
    redirect_to survey_costs_path if current_user
  end
end
