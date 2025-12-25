module Token
  Error = Class.new RuntimeError
  Expired = Class.new Error
  Invalid = Class.new Error

  module_function
  #
  # your validation logic with raising errors here
  #
  def validate(token)
    true
  end
end
