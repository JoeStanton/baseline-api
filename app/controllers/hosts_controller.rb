class HostsController < ApplicationController
  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all

    render json: @hosts
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
    @host = Host.find_by(hostname: params[:id])

    render json: @host
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(host_params)

    if @host.save
      render json: @host, status: :created, location: @host
    else
      render json: @host.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    @host = Host.find_by(hostname: params[:id]) ||
              Host.create(host_params.merge({hostname: params[:id]}))

    if @host.update(host_params)
      head :no_content
    else
      render json: @host.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host = Host.find_by(hostname: params[:id])
    @host.destroy

    head :no_content
  end

  private

  def slugs_to_ids(hash)
    transformed = hash.clone
    slug = transformed[:host].delete('service_slug')
    service = Service.find_by!(slug: slug) if slug
    transformed[:host][:service_id] = service.id if service
    transformed
  end

  def host_params
    slugs_to_ids(params).require(:host).permit(:hostname, :ip, :environment, :service_id, :status, :status_message)
  end
end
