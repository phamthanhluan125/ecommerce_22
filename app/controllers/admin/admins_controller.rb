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
    load_chart_this_week
  end

  private

  def load_chart_this_week
    @label_chart = []
    (0..6).each do |i|
      @label_chart.push (Date.today - (6 - i)).strftime("%d/%m")
    end
    @data_chart = []
    @data_chart.push load_chart(User)
    @data_chart.push load_chart(Order)
    @data_chart.push load_chart(Rate)
    @data_chart.push load_chart(Suggest)
    @data_chart1 = @data_chart.to_json
  end

  def load_chart modal
    list = {}
    list[:name] = modal.to_s
    list_count = []
    (0..6).each do |i|
      list_count. push modal.this_day(Date.today - (6-i)).count
    end
    list[:data] = list_count
    list
  end
end
