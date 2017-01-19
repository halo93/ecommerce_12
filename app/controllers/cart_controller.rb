class CartController < ApplicationController
  def index
    @cart = session[:cart] ? session[:cart] : {}
    @product_carts = @cart.map do |id, cart_params|
      [Product.find_by(id: id), cart_params]
    end
  end

  def create
    id = params["product_id"]
    name = params["product_name"]
    image_url = params["image_url"]
    session[:cart] = {} unless session[:cart]
    cart = session[:cart]
    if cart[id]
      cart[id]["quantity"] = cart[id]["quantity"].to_i + 1
    else
      quantity = 1
      cart[id] = {
        "quantity" => quantity, "name" => name, "image_url" => image_url
      }
    end
    respond_to do |format|
      format.html{render partial: "cart_item", locals: {cart: cart}}
    end
  end

  def update
    data = params["cart"]
    data.each{|key, value| session[:cart][key]["quantity"] = value}
    redirect_to new_order_path
  end

  def destroy
    session[:cart][params[:id]] = nil
    session[:cart].delete_if{|_key, value| value.blank?}
    redirect_to action: :index
  end
end
