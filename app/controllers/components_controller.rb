class ComponentsController < ApplicationController
  # GET /components
  # GET /components.json
  def index
    @components = service.components

    render json: @components
  end

  # GET /components/1
  # GET /components/1.json
  def show
    @component = service.components.find_by(slug: params[:id])

    render json: @component
  end

  # POST /components
  # POST /components.json
  def create
    @component = service.components.new(component_params)

    if @component.save
      render json: @component, status: :created, location: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    @component = service.components.find_by!(slug: params[:id])

    if @component.update(component_params)
      head :no_content
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component = Component.find_by(slug: params[:id])
    @component.destroy

    head :no_content
  end

  def service
    Service.find_by!(slug: params[:service_id])
  end

  def component_params
    params.require(:component).permit(:name, :description, :status, :status_message)
  end
end
