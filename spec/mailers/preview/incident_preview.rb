class IncidentPreview < ActionMailer::Preview
  def detected
    incident = Incident.new(id: 101, service: Service.first, created_at: DateTime.now)
    incident.components << Component.new(name: "Nginx")
    incident.hosts << Host.new(hostname: "rb-prod-01")
    IncidentMailer.detected(incident)
  end

  def resolved
    incident = Incident.new(id: 101, service: Service.first, created_at: 1.hours.ago, resolved_at: 20.minutes.ago)
    incident.components << Service.first.components.first
    incident.hosts << Service.first.hosts.first
    IncidentMailer.resolved(incident)
  end
end
