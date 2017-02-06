class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :remote_avatar_url
  has_many :comments
  has_many :orders
  has_many :favorites
  has_many :suggests
  before_save :init_role

  ratyrate_rater

  scope :admin_email, ->(){self.select(:id, :email).where role: :admin}

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end

  enum role: [:admin, :user]

  private
  def init_role
    self.role ||= :user
  end
end
