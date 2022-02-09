module ApplicationHelper
  def formatted_price_with_currency(price_cents)
    number_to_currency(price_cents / 100.0, unit: 'CHF', delimiter: "'", format: '%n %u')
  end

  def format_timestamp(timestamp)
    return if timestamp.nil?

    "#{distance_of_time_in_words(Time.now, timestamp)} ago (#{timestamp.strftime('%d.%m.%Y')})"
  end
end
