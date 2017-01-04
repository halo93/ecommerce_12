class User < ApplicationRecord
  has_many :rates, :comments, :order, :favorites, :suggests
end
