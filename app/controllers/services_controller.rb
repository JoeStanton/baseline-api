class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    @services = Service.all

    render json: @services
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = Service.find_by(slug: params[:id])

    render json: @service
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    if @service.save
      render json: @service, status: :created, location: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    components = service_params.delete(:components)
    @service = Service.find_by(slug: params[:id]) || Service.create(service_params)
    if components
      @service.update_components(components)
    end

    if @service.update(service_params)
      head :no_content
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find_by(slug: params[:id])
    @service.destroy

    head :no_content
  end

  def spec
    @service = Service.find_by(slug: params[:id])
    if @service
      render text: @service.spec
    else
      render text: "404 Not Found", status: 404
    end
  end

  private

  def service_params
    params.require(:service).permit!
    #(:name, :description, :status, :components => [])
  end
end
