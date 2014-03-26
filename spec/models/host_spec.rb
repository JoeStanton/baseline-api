describe Host do
  it "should produce event on create" do
    host = Host.create
    host.events.should have(1).item
  end

  it "should produce event on destroy" do
    host = Host.create
    id = host.id
    host.destroy!
    Event.where(host_id: id).should have(2).items
  end
end
