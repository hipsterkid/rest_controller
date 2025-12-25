module AutoRender
  module_function

  def [](*methods)
    Module.new do
      define_singleton_method(:included) do |controller|
        controller.prepend Module.new {
          for method in methods
            define_method(method) { render request.format.symbol => super() }
          end
        }
      end
    end
  end
end
