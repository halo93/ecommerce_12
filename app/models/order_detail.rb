class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :product_code, to: :product, prefix: true
end
