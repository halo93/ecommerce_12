class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  has_many :order_details

  before_create :init_status_order, :init_order_code
  validates :shipping_address, presence: true

  delegate :name, to: :user, prefix: true

  scope :monthly_order, ->(start_date, end_date) do
    where "date(updated_at) > '#{start_date}' AND
      date(updated_at) <'#{end_date})'"
  end

  enum status: [:in_progress, :shipping, :delivered, :rejected]

  def calc_total_pay product_carts
    each_amount = []
    if product_carts
      product_carts.each do |product, cart_params|
        each_amount << ApplicationController.helpers
          .calc_price_of_order_detail(product, cart_params["quantity"])
      end
    end
    total_pay = each_amount.reduce(0){|total_pay, price| total_pay += price}
  end

  def update_order! session_cart, address, phone
    product_carts = session_cart.map do |id, cart_params|
      [Product.find_by(id: id), cart_params]
    end
    ActiveRecord::Base.transaction do
      begin
        session_cart.keys.each do |item|
          quantity = session_cart[item]["quantity"].to_i
          order_detail = order_details.build
          product_in_order = Product.find_by id: item.to_i
          rest_quantity = product_in_order.in_stock - quantity
          product_in_order.update_attributes! in_stock: rest_quantity
          price = ApplicationController.helpers
            .calc_price_of_order_detail product_in_order, quantity
          order_detail.update! quantity: quantity,
            product_id: item.to_i,
            price: price
          order_detail.save!
        end
        self.update_attributes! total_pay: calc_total_pay(product_carts),
          shipping_address: address, phone: phone
        session_cart.clear
      rescue ActiveRecord::RecordInvalid
      end
    end
  end

  def self.to_xls records = [], options = {}
    CSV.generate options do |csv|
      csv << [I18n.t("id"), I18n.t("order_code"), I18n.t("status"),
        I18n.t("total_pay"), I18n.t("shipping_address"), I18n.t("phone"),
        I18n.t("admin.categories.index.created_at"),
        I18n.t("admin.orders.order.updated_at")]
      records.each do |order|
        csv << [order.id, order.order_code, order.status, order.total_pay,
          order.shipping_address, order.phone, order.created_at, order.updated_at]
      end
    end
  end

  private
  def init_status_order
    self[:status] = :in_progress
  end

  def init_order_code
    self[:order_code] = Settings.bill <<
      Time.now.strftime(Settings.bill_date)
  end
end
