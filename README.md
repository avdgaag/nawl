# Nawl [![Build Status](https://secure.travis-ci.org/avdgaag/nawl.png?branch=master)](http://travis-ci.org/avdgaag/nawl)

Nawl is a gem that adds custom null objects to your Rails models. These null
objects are perfect for encapsulating the logic in the case of a missing
record, such as a post's missing author or a product's missing image.

## Installation

Add this line to your application's Gemfile:

    gem 'nawl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nawl

## Usage

A quick usage example:

```ruby
class Post
  include Nawl
  has_null_object title: 'Untitled'
end

Post.new.title               # => nil
Post.new.author_name         # => nil
Post.null_object.title       # => 'Untitled'
Post.null_object.author_name # => nil
Post.null_object.class       # => Post
```

A simple object generator is included, for those special cases where you want to
represent nested objects in your null object:

```ruby
class Photo
  has_atached_file :image
  has_one :post
end

class Post
  belongs_to :photo

  include Nawl
  has_null_object image: Nawl.chain(
    'photo.image.url',
    'http://placekitten.com/g/200/200'
  )
end

Post.null_object.photo.image.url
# => 'http://placekitten.com/g/200/200'
Post.null_object.photo.image.foo_bar
# => nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
