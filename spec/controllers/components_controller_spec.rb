require 'spec_helper'
describe ComponentsController do
  before(:all) do
    @service = Service.create(name: "A")
    @component = @service.components.create(name: "Existing component")
  end

  describe "GET index" do
    it "renders all components" do
      get :index, service_id: @service
      assert_response :success
      assigns components: [@component]
    end
  end

  describe "GET show" do
    it "renders all components" do
      get :show, service_id: @service, id: @component.slug

      assert_response :success
      assigns component: @component
    end
  end

  #describe "PUT components" do
    #it "updates an existing component" do
      #put :update, service_id: @service, id: @component, component: { description: "New description" }
      #assert_response :success

      #component.reload.description.should == "New description"
    #end
  #end

  #describe "PUT component status" do
    #it "updates component status and triggers an incident" do
      #put :update, service_id: @service, id: @component, component: { status: "error" }
      #assert_response :success

      #component.service.open_incident.should be_present
    #end

    #it "updates component status and closes an incident" do
      #put :update, service_id: @service, id: @component, component: { status: "ok" }
      #assert_response :success

      #component.service.open_incident.should_not be_present
    #end
  #end
end
