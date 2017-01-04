class Product < ApplicationRecord
  belongs_to :category
  has_manny :rates, :order_details, :favorites, :comments, :component_details
end
