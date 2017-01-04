class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  has_many :order_details
end
