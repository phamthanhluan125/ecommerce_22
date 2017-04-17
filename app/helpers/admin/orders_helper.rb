module Admin::OrdersHelper
  def next_button status
    if status < Setting.end_status_order
      Order.statuses.key(status + 1)
    else
       Order.statuses.key(status)
    end
  end
end
