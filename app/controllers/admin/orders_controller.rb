class Admin::OrdersController < AdminController
  layout "admin_layout"
  before_action :check_admin

  def index
    @orders = Order.all_orders.paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def show
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "find_error"
      redirect_to admin_orders_path
    else
      @order_details = @order.order_details
    end
  end

  def update
    order = Order.find_by id: params[:id]
    if order
      if Order.statuses[order.status] < Settings.end_status_order
        order.status = Order.statuses.key Order.statuses[order.status] + 1
        if order.save
          flash[:success] = t "update_order_success"
        else
          flash[:danger] = t "update_order_fail"
        end
      end
    else
      flash[:danger] = t "find_error"
    end
    redirect_to :back
  end

  private
  def order_params
    params.require(:order).permit :address, :phone, :note, :status, :discount, :user_id
  end
end
