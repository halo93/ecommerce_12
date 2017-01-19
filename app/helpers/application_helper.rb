module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def render_404
    render file: "public/404.html", layout: false, status: 404
  end

  def active_class link_path
    current_page?(link_path) ? "active" : ""
  end

  def calc_price_of_order_detail product, quantity
    product.price * quantity.to_i
  end

  def active_class_admin link_path
    current_page?(link_path) ? "grey white-text darken-3" : ""
  end

  def active_class_locale locale
    locale == I18n.locale ? "active" : ""
  end

  def active_icon_admin link_path
    current_page?(link_path) ? "deep-orange-text" : ""
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def convert_datetime date
    date.to_formatted_s :long
  end
end
