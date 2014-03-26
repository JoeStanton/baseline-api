describe Incident do
  it "should be resolved when all problem nodes return an OK state" do
    service = Service.create(name: "Fake Service")
    service.update(status: "error")
    incident = service.open_incident
    service.update(status: "ok")

    incident.reload.should be_resolved
  end
end
