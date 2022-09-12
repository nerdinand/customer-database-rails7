# Rails 7 sample project

This is a Rails 7 sample project for educational purposes.

It is a simple project dealing with customers, products, orders and line items.

This app is deployed publicly [here](https://customer-database-rails7.fly.dev/).

## Local (default) Setup

1. Download or clone this repository
2. Run `bundle install --without production` in project directory
3. Run `rails db:migrate` in project directory
4. Run `rails runner db/populate_with_fake_data.rb` to generate some fake data to work with. This can take a while because product pictures are being downloaded.
5. Run `rails server` in project directory
6. Visit `http://localhost:3000`

## Local (docker-compose) setup

1. Download or clone this repository
2. Run `docker-compose up` in project directory. This will build the necessary images for the PostgreSQL database and the Rails app and start them.
3. Run `docker-compose run web rails db:create` in project directory.
4. Run `docker-compose run web rails db:migrate` in project directory.
5. Run `docker-compose run web rails runner db/populate_with_fake_data.rb` in project directory to generate some fake data to work with. This can take a while because product pictures are being downloaded.
6. Visit `http://localhost:3000`
