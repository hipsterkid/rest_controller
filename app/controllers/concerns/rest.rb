module Rest
  METHODS = %w(index show create update destroy)

  module_function

  def [](model)
    Module.new do
      define_singleton_method(:included) do |controller|
        controller.include ModelRecord[model]
      end

      include AutoRender[*METHODS]

      define_method(:index) { model.all }
      define_method(:show) { record }
      define_method(:create) { model.create!(permited_params) }
      define_method(:update) { record.update!(permited_params) }
      define_method(:destroy) { record.destroy! }

      define_method(:permited_params) do
        params.permit(*model.url_attributes).to_h
      end
    end
  end
end
