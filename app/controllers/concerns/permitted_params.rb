module PermittedParams
  def self.[](*param_names)
    Module.new do
      define_singleton_method(:included) do |controller|
        permits = controller.instance_variable_defined?(:@permits) ?
          controller.instance_variable_get(:@permits) : []
        controller.instance_variable_set(:@permits, permits + [param_names])
      end

      def permitted_params
        params.permit(*self.class.instance_variable_get(:@permits))
      end
    end
  end
end
