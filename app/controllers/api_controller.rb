class ApiController < ApplicationController
  def index
    render json: {
      services: services_url,
      hosts: hosts_url,
      events: events_url,
      incidents: incidents_url
    }
  end
end
