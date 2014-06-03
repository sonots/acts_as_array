# Acts as array

`acts_as_array` makes possible to treat your array fields simply.

[![Build Status](https://travis-ci.org/sonots/acts_as_array.svg)](https://travis-ci.org/sonots/acts_as_array)
[![Coverage Status](https://coveralls.io/repos/sonots/acts_as_array/badge.png)](https://coveralls.io/r/sonots/acts_as_array)

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'acts_as_array'
```

And then execute:

```plain
$ bundle
```

## What is this for?

Say an user has multiple mail addresses. Typically you will define table schema as:

```ruby
create_table :users do |t|
  t.string :name
end

create_table :mails do |t|
  t.string :address
  t.references :user
end
```

And, define ActiveRecord models as:

```ruby
class Mail < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :mails
end
```

In this case, you will store multiple mail addresses to an users like:

```ruby
ichiro = User.new(name: 'Ichiro')
ichiro.mails = [Mail.new(address: 'ichiro@example.com'), Mail.new(address: 'ichiro2@example.com')]
ichiro.save
```

But, you want to set multiple mail addresses simply like followings?:

```ruby
ichiro = User.new(name: 'Ichiro')
ichiro.mails = ['ichiro@example.com', 'ichiro2@example.com']
ichiro.save
```

Then, `acts_as_array` is available for you. 


### With acts_as_array

Use `acts_as_array` as:

```ruby
class Mail < ActiveRecord::Base
  belongs_to :user
end

require 'acts_as_array'
class User < ActiveRecord::Base
  has_many :mails
  include ActsAsArray
  acts_as_array :mails => {:field => :address}
end
```

Then, it makes possible to set and get non-object array values like:

```ruby
ichiro = User.new(name: 'Ichiro')
ichiro.mails = ['ichiro@example.com', 'ichiro2@example.com']
ichiro.save
User.first.mails #=> ['ichiro@example.com', 'ichiro2@example.com']
```

You can also get the original object array values with:

```ruby
ichiro.obj_mails #=> [Mail.new(address: 'ichiro@example.com'), Mail.new(address: 'ichiro2@example.com')]
```

## Supported methods

Following ActiveRecord methods are supported to specify non-object array values:

* create

  `create(field: non_object_array)`

* update_attributes

   `update_attributes(field: non_object_array)`

* update

   `update(field: non_object_array)`

* {field}=

   `{field} = non_object_array`

Also, following getter methods are available:

* {field}

  Return non-object array values

* obj_{field}

  Return object array values

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

* Copyright (c) 2014 Naotoshi Seo. See [LICENSE](LICENSE) for details.
