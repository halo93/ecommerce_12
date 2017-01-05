class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :order_details
  has_many :favorites
  has_many :comments
  has_many :component_details
end
