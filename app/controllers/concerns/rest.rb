module Rest
  METHODS = %w[index show create update destroy]

  module_function

  def [](model)
    Module.new do
      define_singleton_method(:included) do |controller|
        controller.include PermittedParams[*model.http_attributes]

        # raise all nessesary resource errors here
        controller.rescue_from(ActiveRecord::RecordNotFound) { head :not_found }
      end

      include AutoRender[*METHODS]

      def index = resource_class.all
      def show = resource
      def create = resource_class.create!(permitted_params.to_h)
      def update = resource.update!(permitted_params.to_h)
      def destroy = resource.destroy!

      define_method(:resource_class) { model }
      define_method(:resource) { @resource ||= model.find(params[:id]) }
    end
  end
end
