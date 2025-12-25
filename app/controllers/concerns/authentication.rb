module Authentication
  def self.included(controller)
    controller.before_action { |instance| Token.validate(instance.params[:token]) }

    # or separate errors for Expired, Invalid and other exceptions
    controller.rescue_from Token::Error, with: :access_denied
  end

  def access_denied
    head :forbidden
  end
end
