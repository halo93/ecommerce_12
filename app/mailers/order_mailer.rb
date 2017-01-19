class OrderMailer < ApplicationMailer
  def order_confirm order, customer
    @order = order
    mail to: customer.email, subject: t("order_confirm")
  end
end
