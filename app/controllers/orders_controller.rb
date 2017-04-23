class OrdersController < ApplicationController

  before_action :function_logged_in_use, only: [:index, :show]

  def update
    @order = Order.find_by id: params[:id]
    if @order.update_attributes order_params
      flash[:success] = t "update_success"
    else
      flash.now[:danger] = t "update_fail"
    end
    redirect_to :back
  end

  def create
    @order = Order.new order_params
    @order.delivery_day = DateTime.now + Settings.delivery_day
    @order.user_id = current_user.id
    @carts = session[:cart]
    @order.transaction do
      if @order.save
        @carts.each do |c|
          @orderdetail = @order.order_details.new product_id: c["product_id"],
            quantity: c["quantity"], note: c["note"], price: c["price"]
          @orderdetail.transaction do
            raise t "create_order_fail" unless @orderdetail.save!
          end
        end
        send_notification @order.id
        OrderUserMailer.order_to_user(current_user, @carts, @order).deliver
        session[:cart].clear
        flash[:success] = t "create_order_success"
        binding.pry
        redirect_to root_path
      else
        flash[:danger] = t "create_order_fail"
        redirect_to :back
      end
    end
  end

  def index
    @orders = current_user.orders.paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def show
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "find_error"
      redirect_to admin_orders_path
    else
      @order_details = @order.order_details.paginate page: params[:page],
      per_page: Settings.maximum_per_page
    end
  end

  def destroy
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "find_error"
      redirect_to admin_orders_path
    else
      @order.status = "cancel"
      if @order.save
        flash[:success] = t "cancel_order_success"
      else
        flash[:danger] = t "cancel_order_fail"
      end
    end
    redirect_to orders_path
  end

  private

  def send_notification order_id
    admins = User.all_admin
    admins.each do |a|
      notification = NotificationMessage.new
      notification.content = t "noti.new.order"
      notification.url = admin_order_path order_id
      notification.user_id = a.id
      if notification.save
        NotificationJob.perform_now notification
      end
    end
    notification = NotificationMessage.new
    notification.content = t("noti.order.created", id: order_id)
    notification.url = order_path order_id
    notification.user_id = current_user.id
    if notification.save
      NotificationJob.perform_now notification
    end
  end

  def order_params
    params.require(:order).permit :address, :phone, :note,
      :status, :discount, :user_id
  end
end
