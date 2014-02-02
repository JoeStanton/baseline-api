class ComponentsController < ApplicationController
  # GET /components
  # GET /components.json
  def index
    @components = Component.all

    render json: @components
  end

  # GET /components/1
  # GET /components/1.json
  def show
    @component = Component.find(params[:id])

    render json: @component
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(params[:component])

    if @component.save
      render json: @component, status: :created, location: @component
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    @component = Component.find(params[:id])

    if @component.update(params[:component])
      head :no_content
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    head :no_content
  end
end
