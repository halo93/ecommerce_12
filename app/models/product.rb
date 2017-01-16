class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :order_details
  has_many :favorites
  has_many :comments
  has_many :component_details

  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :product_code, presence: true, length: {maximum: 10}
  validates :price, presence: true
  validates :in_stock, presence: true

  delegate :name, :depth, to: :category, prefix: true

  scope :in_category,
    ->category_id{where category_id: category_id if category_id.present?}

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.import file
    spreadsheet = open_spreadsheet file
    header = spreadsheet.row(1)
    flag = true
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["id"]) || new
      product.attributes = row.to_hash.slice(*row.to_hash.keys)
      if product.valid?
        product.save!
      else
        flag = false
        break
      end
    end
    flag
  end

  def self.open_spreadsheet file
    case File.extname file.original_filename
    when ".csv" then Roo::CSV.new file.path
    when ".xls" then Roo::Excel.new file.path
    when ".xlsx" then Roo::Excelx.new file.path
      else raise "Unknown file type"
    end
  end
end
