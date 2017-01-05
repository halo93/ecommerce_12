class User < ApplicationRecord
  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :rates
  has_many :comments
  has_many :orders
  has_many :favorites
  has_many :suggests
  before_save :init_role

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.avatar = auth.info.picture
      user.password = Devise.friendly_token[0, 20]
    end
  end

  enum role: [:admin, :user]

  private
  def init_role
    self.role ||= :user
  end
end
