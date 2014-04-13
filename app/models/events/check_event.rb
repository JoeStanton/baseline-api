class CheckEvent < Event
  after_create :detect_incident
  after_create :update_incident_status!

  def detect_incident
    return if ok? and not service.open_incident
    incident = service.open_incident || Incident.create(service: service)
    incident.events << self
  end

  def update_incident_status!
    incident.update_status! if incident
  end

  def subject
    component || host || service
  end
end
