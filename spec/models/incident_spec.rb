describe Incident do
  it "should be resolved when all problem nodes return an OK state" do
    service = Service.create(name: "Fake Service")
    service.update(status: "error")
    incident = service.open_incident
    service.update(status: "ok")

    incident.reload.should be_resolved
  end

  it "should trigger an email when detected" do
    service = Service.create(name: "Fake Service")
    IncidentMailer.stub_chain(:detected, :deliver)
    Incident.create(status: "open", service: service)
  end

  it "should trigger an email when resolved" do
    service = Service.create(name: "Fake Service")
    incident = Incident.create(status: "open", service: service)
    incident.resolve

    IncidentMailer.stub_chain(:resolved, :deliver)
  end
end
