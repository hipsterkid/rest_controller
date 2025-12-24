class User < ApplicationRecord
  has_secure_password

  def self.maintainable_attributes
    %w(email password)
  end
end
