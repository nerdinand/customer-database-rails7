class Cart
  include ActiveModel::Model

  attr_accessor :product_ids, :amounts, :customer_id

  def initialize(attributes = {})
    super
    @product_ids ||= []
    @amounts ||= []
  end

  def self.from_session(session)
    if session[:cart]
      new(session[:cart])
    else
      new
    end
  end

  def add_line_item(product_id, amount)
    product_ids << product_id
    amounts << amount
  end

  def remove_line_item(index)
    product_ids.delete_at(index)
    amounts.delete_at(index)
  end

  def products
    product_ids.map do |product_id|
      Product.find(product_id)
    end
  end

  def empty?
    product_ids.none?
  end

  def check_out!
    order = Order.create(
      placed_at: Time.zone.now,
      customer_id: customer_id
    )

    product_ids.each.with_index do |product_id, index|
      LineItem.create(
        order: order,
        product_id: product_id,
        amount: amounts[index]
      )
    end
  end
end
