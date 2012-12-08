require 'spec_helper'

describe Siblings::DeploysController do
  describe "GET index" do
    it "assigns all siblings deploys to @siblings_deploys" do
      siblings_deploys = stub_model(Sibling::Deploy)
      Sibling::Deploy.stub(:all) { [siblings_deploys] }
      get :index
      expect(assigns(:siblings_deploys)).to eq([siblings_deploys])
    end
  end
end
