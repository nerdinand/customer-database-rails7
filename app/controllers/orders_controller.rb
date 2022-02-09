class OrdersController < ApplicationController
  def index
    @orders = if params[:paid]
      Order.where.not(paid_at: nil)
    elsif params[:delivered]
      Order.where.not(delivered_at: nil)
    else
      Order.all
    end
  end

  def show
    customer = Customer.find(params[:customer_id])
    @order = customer.orders.find(params[:id])
  end

  def paid
    customer = Customer.find(params[:customer_id])
    @order = customer.orders.find(params[:order_id])

    @order.paid!

    if @order.save
      flash[:notice] = 'Order marked as paid.'
    else
      flash[:alert] = 'Error marking order as paid.'
    end

    redirect_to customer_order_path(customer, @order)
  end

  def delivered
    customer = Customer.find(params[:customer_id])
    @order = customer.orders.find(params[:order_id])

    @order.delivered!

    if @order.save
      flash[:notice] = 'Order marked as delivered.'
    else
      flash[:alert] = 'Error marking order as delivered.'
    end

    redirect_to customer_order_path(customer, @order)
  end
end
