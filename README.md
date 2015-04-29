# RSpec Demo

## Running the tests

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
