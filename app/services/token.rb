module Token
  Error = Class.new RuntimeError
  Expired = Class.new Error
  Invalid = Class.new Error

  module_function

  def validate(token)
    return true if token && token == ENV['GODMODE_AUTHTOKEN']
    #
    # your validation logic with raising errors here:
    #
    raise Error
  end
end
