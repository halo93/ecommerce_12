class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :order_details
  has_many :favorites
  has_many :comments
  has_many :component_details

  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :product_code, presence: true, length: {maximum: 10}
  validates :price, presence: true
  validates :in_stock, presence: true

  delegate :name, :depth, to: :category, prefix: true

  scope :in_category, ->category_id{
    where category_id: category_id if category_id.present?
  }
end
