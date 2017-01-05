# Metadata

![Metadata Build Status from Travis-CI](https://secure.travis-ci.org/colinyoung/metadata.png)

## Usage

```ruby
class User < ActiveRecord::Base
  ...
  metadata do |obj|
    puts obj.name
    is a: 'user'
    with friends: obj.friends.count
    stop
  end
  ...
end
```
    
Results in

    Joe is a user with 37 friends.
    
Why is this useful?

* Translation
* Other formats

## Installation

Add this line to your application's Gemfile:

    gem 'metadata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metadata

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
