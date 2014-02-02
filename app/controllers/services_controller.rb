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
    @service = Service.find(params[:id])

    render json: @service
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(params[:service])

    if @service.save
      render json: @service, status: :created, location: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @service = Service.find(params[:id])

    if @service.update(params[:service])
      head :no_content
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    head :no_content
  end
end
