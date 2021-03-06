# RSpec

## Running RSpec

1. `bundle exec rake db:create:all`
2. `bundle exec rspec`

## Notes

This demo showcases several gems/techniques for RSpec. This is a simple
app where the homepage allows you to signup and sign in. The forms
simply makes AJAX calls to the api endpoints `POST /api/users` and `POST
/api/sessions`.

In addition to the `User` model, there are `Reviews` where users can
review one another. I didn't build a UI to create/view reviews, but
there is a controller `Api::ReviewsController` and a corresponding spec.

The `Api::UsersController` and `Api::SessionsController` specs showcases
testing for response codes and basic logic validation.

The `api/reviews#create` showcases mocking a service call, which then
ideally there's a unit test for the `CreateReviewService`.

The `specs/models/review.rb` showcases a simple method test. Nothing
interesting here, but thought I'd include it for completeness.

The `spec/factories/` directory contains all the factories used in the
tests. Notably in the `spec/factories/review.rb`, you'll see the
following directive:

```ruby
association :reviewer, factory: :user
```

By default this will create a new user so that creating a single review
will always be in a valid state, but you can set your own user for finer
grained control when calling `FactoryGirl.create`. You can see an
example of this in `specs/controllers/api/reviews_controller_spec.rb`.


## Notable gems used

* `database_cleaner` - Helps reset the database before each test
* `factory_girl_rails` - Provides factory methods to build models +
  relationships
* `faker` - Simple data faking gem i.e. email, names, text, etc.

# Capybara

Used both `selenium-webdriver` as well as `poltergeist` (phantomjs) as
the drivers for `capybara`. Poltergeist is the way to go but there's an
issue on one of my machines (can't repo it on another MBP).

## Running Capybara

```bash
export CAPYBARA_HOST=http://staging-url.com
export CAPYBARA_EMAIL=login+email@gmail.com
export CAPYBARA_PASSWORD=somepw
bundle exec rspec spec/features
```

## Notable gems used

* `selenium-webdriver` - The Selenium Webdriver executes the test within
  a Browser environment (by default it starts up Firefox)
* `poltergeist` - A driver that connects to PhantomJS. This is faster
  than selenium and much more flexible since it's headless (i.e. you can
  run it in a CI environment). Unfortunately, it has this weird bug where
  the cookies wouldn't clear in between test runs. My guess is that it's a
  PhantomJS bug (I'm running `2.0.0`) but not sure.
