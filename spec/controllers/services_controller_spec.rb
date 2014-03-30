require 'spec_helper'
describe ServicesController do
  describe "GET index" do
    it "renders all services" do
      get :index
      assert_response :success
    end
  end

  describe "GET index" do
    it "renders all services" do
      @service = Service.create(name: "Service A")
      get :index
      assert_response :success
      assigns services: [@service]
    end
  end

  describe "GET show" do
    it "renders all services" do
      @service = Service.create(name: "Service A")
      get :show, id: @service.slug

      assert_response :success
      assigns service: @service
    end
  end

  describe "PUT services" do
    it "adds a new service with associated components" do
      put :update, id: "new-service", service: {name: "New Service"}
      assert_response :success
      service = Service.find_by(slug: "new-service")
      service.should be_present
      service.name.should == "New Service"
    end

    it "updates an existing service" do
      service = Service.create(name: "Existing Service")
      put :update, id: "existing-service", service: { description: "New description" }
      assert_response :success

      service.reload.description.should == "New description"
    end
  end

  describe "PUT service status" do
    it "updates service status and triggers an incident" do
      service = Service.create(name: "Problematic Service")
      put :update, id: "problematic-service", service: { status: "error" }
      assert_response :success

      service.open_incident.should be_present
    end

    it "updates service status and closes an incident" do
      service = Service.create(name: "Problematic Service")
      put :update, id: "problematic-service", service: { status: "ok" }
      assert_response :success

      service.open_incident.should_not be_present
    end
  end
end
