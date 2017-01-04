class Category < ApplicationRecord
  has_manny :products, :suggests
end
