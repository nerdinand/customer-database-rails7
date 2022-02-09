# Rails 7 sample project

This is a Rails 7 sample project for educational purposes.

It is a simple project dealing with customers, products, orders and line items.

_TODO_: Link to deployment

## Setup

1. Download or clone this repository
2. Run `bundle install --without production` in project directory
3. Run `rails db:migrate` in project directory
4. Run `rails runner db/populate_with_fake_data.rb` to generate some fake data to work with. This can take a while because product pictures are being downloaded.
5. Run `rails server` in project directory
6. Visit `http://localhost:3000`
