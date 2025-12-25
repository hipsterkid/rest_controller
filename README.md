# Universal REST controller with Authentication and AutoRender

This is a sample __Rails__ application with some fun (_not boring_) stuff:

* Universal __Rest module__ for controllers
* Universal __AutoRender module__ in for makes actions responsable
* Universal __Authentication module__ with param Token service (blank)

It has a lot of things happens _on fly_ via initialization (like _metaprogramming_).

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

TODO

# Install & Run

TODO

# Contribute

You are welcome!

__Ruby rules!__
