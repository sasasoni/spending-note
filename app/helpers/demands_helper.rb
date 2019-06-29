module DemandsHelper
  def guest_or_user_demands_path(guest)
    if guest
      demands_path(user: guest[:user], key: guest[:key])
    else
      demands_path
    end
  end

  def guest_or_user_demand_path(guest, demand)
    if guest
      demand_path(demand, user: guest[:user], key: guest[:key])
    else
      demand
    end
  end

  def guest_or_user_edit_demand_path(guest, demand)
    if guest
      edit_demand_path(demand, user: guest[:user], key: guest[:key])
    else
      edit_demand_path(demand)
    end
  end
end
