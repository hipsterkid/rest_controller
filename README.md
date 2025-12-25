# Universal REST controller with AutoRender and Authentication

This is a sample __Rails__ application with some fun (_not boring_) stuff:

* Universal __Rest module__ for controllers
* Universal __AutoRender module__ in for makes actions responsable
* Universal __Authentication module__ with param Token service (blank)

It has a lot of things happens _on fly_ at initialization (like _metaprogramming_).

For example it takes __User__ model:

```ruby
class UsersController < ApplicationController
  include Authentication
  include Rest[User]
end
```

__Specs__ (basics) for REST'ing users are included.

# Files

Check this out:

* [app/models/user.rb](app/models/user.rb)
* [app/controllers/users\_controller.rb](app/controllers/users\_controller.rb)
* [app/controllers/concerns/authentication.rb](app/controllers/concerns/authentication.rb)
* [app/controllers/concerns/auto\_render.rb](app/controllers/concerns/auto\_render.rb)
* [app/controllers/concerns/model\_record.rb](app/controllers/concerns/model\_record.rb)
* [app/controllers/concerns/rest.rb](app/controllers/concerns/rest.rb)
* [app/services/token.rb](app/services/token.rb)
* [specs/requests/rest\_users\_spec.rb](specs/requests/rest\_users\_spec.rb)

# Install & Run

```bash
git clone https://github.com/hipsterkid/rest_controller.git

cd rest_controller

bundle

# specs
bundle exec rspec

# or serve
bin/rails s
```

# Contribute

You are welcome! Suggest something more in any time!

__Ruby rules!__
