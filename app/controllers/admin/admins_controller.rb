class Admin::AdminsController < AdminController
  layout "admin_layout"
  before_action :check_admin

  def index
    user_today = User.user_regit_today.count
    order_today = Order.order_create_today.count
    product_total = Product.all.count
    suggest_today = Suggest.suggest_create_today.count
    @general = {user_today: user_today, order_today: order_today,
      rate_today: rate_today, suggest_today: suggest_today}
  end

  def update
    value_type = params[:id]
    case value_type.to_i
    when 0
      load_chart Settings.day7_chart
      render json: {label: @label_chart, data: @data}
    when 1
      load_chart Settings.day10_chart
      render json: {label: @label_chart, data: @data}
    else
      load_chart Settings.day30_chart
      render json: {label: @label_chart, data: @data}
    end
  end

  private

  def load_chart day
    @label_chart = []
    (0..day).each do |i|
      @label_chart.push (Date.today - (day - i)).strftime("%d/%m")
    end
    @data = []
    @data.push load_data_chart(User, day)
    @data.push load_data_chart(Order, day)
    @data.push load_data_chart(Rate, day)
    @data.push load_data_chart(Suggest, day)
  end

  def load_data_chart modal, day
    list = {}
    list[:name] = modal.to_s
    list_count = []
    (0..day).each do |i|
      list_count. push modal.this_day(Date.today - (day-i)).count
    end
    list[:data] = list_count
    list
  end
end
