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
end
