class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :amount, presence: true

  def price_cents
    product.price_cents * amount
  end
end
