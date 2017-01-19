class Admin::ChartsController < ApplicationController
  layout "admin"
  def index
    @user_statistic = User.group_by_day(:created_at, last: 7).count
    @orders_statistic = Order.group_by_day_of_week(:created_at, format: "%^a").count
    @income = Order.group_by_day(:created_at, last: 10).sum(:total_pay)
  end
end
