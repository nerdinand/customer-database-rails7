class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy

  def price_cents
    line_items.sum do |line_item|
      line_item.price_cents
    end
  end

  def paid?
    paid_at.present?
  end

  def delivered?
    delivered_at.present?
  end

  def paid!
    self.paid_at = Time.zone.now
  end

  def delivered!
    self.delivered_at = Time.zone.now
  end
end
