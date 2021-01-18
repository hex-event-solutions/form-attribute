# FormAttribute

![Ruby](https://github.com/hex-event-solutions/form-attribute/workflows/Ruby/badge.svg)

A lightweight gem for adding typed attributes to plain objects

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'form_attribute'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install form_attribute

## Usage

Add the line `extend FormAttribute` to your class, then start defining
attributes as in the example below:

```ruby
class Person
  extend FormAttribute

  attribute :name, String
  attribute :role, String, default: 'user'
  attribute :employee, Boolean, default: true
  attribute :contact, [String, Integer]
  attribute :date_of_birth, Time
end
```

Attribute definitions follow the pattern `attribute <name>, <types>, <options>`.
`<types>` can be an array of allowed types or a single allowed type. When
setting the value, it will be validated against this list of types and will
raise a `TypeError` if the value being set is not one of these types.

Attributes on an object can be read with `Class.attributes`

```ruby
Person.attributes
=> [:name, :role, :employee, :contact, :date_of_birth]
```

The type of an attribute can be read with `Class.type_of(<attribute>)`

```ruby
Person.type_of :name
=> [String]

Person.type_of :contact
=> [String, Integer]
```

The default value of an attribute can be read with
`Class.default_for(<attribute>)`

```ruby
Person.default_for :role
=> "user"
```

Each attribute is available as a method on the object created.

```ruby
person = Person.new
=> #<Person name: nil, role: "user", employee: true, contact: nil, date_of_birth: nil>

person.name
=> nil

person.role
=> "user"
```

Setting attributes is also available as a method

```ruby
person.name = 'John Smith'
=> "John Smith"

person.name
=> "John Smith"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hex-event-solutions/form_attribute. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the
[code of conduct](https://github.com/hex-event-solutions/form_attribute/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FormAttribute project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/hex-event-solutions/form_attribute/blob/master/CODE_OF_CONDUCT.md).

```

```
