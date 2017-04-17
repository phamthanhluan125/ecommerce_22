class Admin::AdminsController < AdminController
  layout "admin_layout"
  before_action :check_admin

  def index
    user_today = User.user_regit_today.count
    order_today = Order.order_create_today.count
    product_total = Product.all.count
    suggest_today = Suggest.suggest_create_today.count
    @general = {user_today: user_today, order_today: order_today,
      product_total: product_total, suggest_today: suggest_today}
  end
end
