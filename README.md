# RocketModel

Simple implementation of ActiveRecord

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rocket_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rocket_model

## Usage

```ruby
class User
  include RocketModel::Base

  attribute :name, :String
  attribute :admin, :Boolean, default: true
end

user = User.new name: "Admin Jonny"
user.name # => "Admin Jonny"
user.admin # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mstolbov/rocket_model.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

