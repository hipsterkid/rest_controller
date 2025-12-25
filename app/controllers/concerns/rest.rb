module Rest
  METHODS = %w[index show create update destroy]

  module_function

  def [](model)
    Module.new do
      define_singleton_method(:included) do |controller|
        controller.include ModelRecord[model]
        controller.include PermittedParams[*model.url_attributes]
      end

      include AutoRender[*METHODS]

      def index = model.all
      def show = record
      def create = model.create!(permitted_params.to_h)
      def update = record.update!(permitted_params.to_h)
      def destroy = record.destroy!
    end
  end
end
