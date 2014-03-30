require 'spec_helper'
describe HostsController do
  before(:all) do
    @service = Service.create(name: "A")
  end

  describe "GET index" do
    it "renders all hosts" do
      @host = Host.create(hostname: "host-a.local")
      get :index, service_id: @service
      assert_response :success
      assigns hosts: [@host]
    end
  end

  describe "GET show" do
    it "renders all hosts" do
      @host = Host.create(hostname: "host-a.local")
      get :show, service_id: @service, id: @host.hostname

      assert_response :success
      assigns host: @host
    end
  end

  describe "PUT host status" do
    it "updates host status and triggers an incident" do
      host = @service.hosts.create(hostname: "problematic-host")
      put :update, service_id: @service, id: "problematic-host", host: { status: "error" }
      assert_response :success

      host.service.open_incident.should be_present
    end

    it "updates host status and closes an incident" do
      host = @service.hosts.create(hostname: "problematic-host")
      put :update, service_id: @service, id: "problematic-host", host: { status: "ok" }
      assert_response :success

      host.service.open_incident.should_not be_present
    end
  end
end
