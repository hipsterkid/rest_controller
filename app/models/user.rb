class User < ApplicationRecord
  has_secure_password

  def self.url_attributes
    %w(email password)
  end
end
