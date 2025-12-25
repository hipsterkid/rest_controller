module ModelRecord
  module_function

  def [](model_class)
    Module.new do
      define_singleton_method(:included) do |controller|
        controller.rescue_from(ActiveRecord::RecordNotFound) { head :not_found }
      end
      define_method(:model) { model_class }
      define_method(:record) { model.find(params[:id]) }
    end
  end
end
