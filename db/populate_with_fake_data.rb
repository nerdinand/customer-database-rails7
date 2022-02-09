require 'faker'
require 'net/http'
require 'tempfile'

Faker::Config.locale = 'de-CH'

def download_lorem_flickr
  http = Net::HTTP.new('loremflickr.com', 443)
  http.use_ssl = true
  
  loremflickr_uri = URI(Faker::LoremFlickr.image(size: '300x300', search_terms: ['products'])).path
  image_uri = http.get(loremflickr_uri)['location']
  response = http.get(image_uri)

  file = Tempfile.new(['image', '.jpg'], encoding: 'ascii-8bit')
  file.write(response.body)
  file.rewind
  file
end

ActiveRecord::Base.connection.transaction do
  10.times do
    Customer.create!(
      name: Faker::Company.name,
      address: Faker::Address.street_address,
      zip_code: Faker::Address.zip_code,
      city: Faker::Address.city,
      phone_number: Faker::PhoneNumber.phone_number
    )
  end

  20.times do
    product_image_file = download_lorem_flickr

    begin
      product = Product.create!(
        name: Faker::Lorem.words(number: 2, supplemental: true).join(' '),
        description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        price_cents: Faker::Number.between(from: 10_00, to: 10000_00)
      )
      product.image.attach(io: product_image_file, filename: 'image.jpg')
      product.save!
    ensure
      product_image_file.unlink
    end
  end

  Customer.all.each do |customer|
    Faker::Number.between(from: 1, to: 10).times do
      has_been_paid = Faker::Boolean.boolean
      has_been_delivered = has_been_paid && Faker::Boolean.boolean

      placed_at = Faker::Time.between(from: 2.years.ago, to: Date.today)
      paid_at = has_been_paid ? Faker::Time.between(from: placed_at, to: placed_at + 1.month) : nil
      delivered_at = has_been_delivered ? Faker::Time.between(from: paid_at, to: paid_at + 1.month) : nil

      order = Order.create!(
        customer: customer,
        placed_at: placed_at,
        paid_at: paid_at,
        delivered_at: delivered_at
      )

      Faker::Number.between(from: 1, to: 10).times do
        LineItem.create!(
          order: order,
          product: Product.all.sample,
          amount: Faker::Number.between(from: 1, to: 10)
        )
      end
    end
  end
end
