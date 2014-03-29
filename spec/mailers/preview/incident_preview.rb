class IncidentPreview < ActionMailer::Preview
  def detected
    incident = Incident.new(id: 101, service: Service.first, created_at: DateTime.now)
    IncidentMailer.detected(incident)
  end

  def resolved
    incident = Incident.new(id: 101, service: Service.first, created_at: 1.hours.ago, resolved_at: 20.minutes.ago)
    IncidentMailer.resolved(incident)
  end
end
