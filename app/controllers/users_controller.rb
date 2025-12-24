class UsersController < ApplicationController
  module Token
    Error = Class.new RuntimeError
    Expired = Class.new Error
    Invalid = Class.new Error

    module_function

    def validate(token)
      true
    end
  end

  module TokenParamAuthentication
    def self.included(controller)
      controller.before_action { |instance| Token.validate(instance.params[:token]) }

      # or separate errors for Expired, Invalid and other exceptions
      controller.rescue_from Token::Error, with: :access_denied
    end

    def access_denied
      head :forbidden
    end
  end

  module ModelRecord
    def self.[](model_class)
      Module.new do
        define_method(:model) { model_class }
        define_method(:record) { model.find(params[:id]) }
      end
    end
  end

  module AutoRender
    def self.[](*methods)
      Module.new do
        define_singleton_method(:included) do |controller|
          controller.prepend Module.new {
            for method in methods
              define_method(method) { render json: super() }
            end
          }
        end
      end
    end
  end

  include TokenParamAuthentication
  include ModelRecord[User]
  include AutoRender[:index, :show, :create, :update, :delete]


  def index
    model.all
  end

  def show
    record
  end

  def create
    model.create!(permited_params)
  end

  def update
    record.update!(permited_params)
  end

  def destroy
    record.destroy!
  end

  private

  def permited_params
    params.permit(*model.maintainable_attributes).to_h
  end
end
