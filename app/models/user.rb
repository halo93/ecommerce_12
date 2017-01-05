class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :rates
  has_many :comments
  has_many :orders
  has_many :favorites
  has_many :suggests
end
