class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
                   .includes(:host)
                   .includes(:service)
                   .includes(:component)

    render json: @events, each_serializer: EventSerializer
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    render json: @event, serializer: EventSerializer
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event.url, serializer: EventSerializer
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    head :no_content
  end

  private

  def slugs_to_ids(hash)
    transformed = hash.clone
    service_slug = transformed[:event].delete('service_slug')
    if service_slug.present?
      service = Service.find_by(slug: service_slug)
      transformed[:event][:service_id] = service ? service.id : nil
    end
    host_slug = transformed[:event].delete('host_slug')
    if host_slug.present?
      host = Host.find_by(hostname: host_slug)
      transformed[:event][:host_id] = host ? host.id : nil
    end
    transformed
  end

  def event_params
    slugs_to_ids(params).require(:event).permit!
  end
end
