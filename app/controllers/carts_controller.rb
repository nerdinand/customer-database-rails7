class CartsController < ApplicationController
  def show
    @cart = Cart.from_session(session)
  end

  def update
    product_id = params['cart']['product_id']
    amount = params['cart']['amount']

    if amount.to_i > 0
      @cart = Cart.from_session(session)
      @cart.add_line_item(product_id, amount)

      session[:cart] = @cart

      flash[:notice] = 'Product added to cart.'
    end

    redirect_to products_path
  end

  def check_out
    @cart = Cart.from_session(session)

    if @cart.empty?
      flash[:alert] = 'No products in cart.'

      redirect_to cart_path
    end
  end

  def confirm_check_out
    @cart = Cart.from_session(session)
    @cart.customer_id = params[:cart][:customer_id]
    @cart.check_out!

    flash[:notice] = 'Order created successfully.'
    session[:cart] = Cart.new

    redirect_to products_path
  end

  def line_item
    index = params['cart']['index'].to_i

    @cart = Cart.from_session(session)
    @cart.remove_line_item(index)

    redirect_to cart_path
  end
end
