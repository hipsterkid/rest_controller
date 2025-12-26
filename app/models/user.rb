class User < ApplicationRecord
  has_secure_password

  def self.http_attributes
    %w[email password]
  end
end
