class Suggest < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, presence: true

  before_create :init_suggest_status

  enum status: [:processing, :accepted, :rejected]

  private
  def init_suggest_status
    self[:status] = :processing
  end
end
