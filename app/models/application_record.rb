class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :order_by_creation_time, ->{order created_at: :asc}
  scope :order_by_updated_time, ->{order updated_at: :desc}

  def self.human_enum_name enum_name, enum_value
    I18n.t("activerecord.attributes.#{model_name.i18n_key}."\
      "#{enum_name.to_s.pluralize}.#{enum_value}")
  end
end
