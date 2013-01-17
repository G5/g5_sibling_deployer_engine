require 'spec_helper'

describe SiblingsController do
  describe "GET index" do
    it "assigns all siblings to @siblings" do
      sibling = stub_model(Sibling)
      Sibling.stub(:all) { [sibling] }
      get :index
      expect(assigns(:siblings)).to eq([sibling])
    end
  end
  describe "#deploy" do
    before :each do
      sibling = stub_model(Sibling)
      Sibling.stub(:find) { sibling }
    end
    it "redirects if deploy succeeds" do
      Sibling.any_instance.stub(:deploy).and_return(true)
      post :deploy, id: 1
      response.should redirect_to(siblings_deploys_path)
    end
    it "redirects if deploy fails" do
      Sibling.any_instance.stub(:deploy).and_return(false)
      post :deploy, id: 1
      response.should redirect_to(siblings_deploys_path)
    end
  end
end
