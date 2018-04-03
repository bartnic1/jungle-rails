# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

### The Main Page:
!["Products listing"](https://github.com/bartnic1/jungle-rails/blob/master/images/Products%20page.png)

### Product Reviews:
!["Review page"](https://github.com/bartnic1/jungle-rails/blob/master/images/Product%20review.png)

## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

## Heroku

Preface all normal action with "heroku run" to run them on heroku. Example:
heroku run rake db:migrate
heroku run rake db:seed
heroku run rake db:reset

Update: May need to remove cl_image_tag from image attribute, so as to just get the URL. But then, how to render
an image in an ERB? Could try cl_image_tag.

https://cloudinary.com/documentation/rails_image_manipulation

## bin/rspec

Note, if you don't want to run all specs, you can specify:
bin/rspec spec/features

To make the tests more verbose, use -fd flag:
bin/rspec -fd --or-- bin/rspec spec/features -fd

## resetting the database

The following command runs all migrations (and hopefully reseeds)
rake db:migrate:reset