class UsersController < ApplicationController
  include Authentication
  include Rest[User]
end
