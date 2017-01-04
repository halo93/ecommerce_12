class ComponentDetail < ApplicationRecord
  belongs_to :component
  belongs_to :product
end
