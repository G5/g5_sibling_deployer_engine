require 'spec_helper'

describe Siblings::InstructionsController do
  describe "GET index" do
    it "assigns all siblings instructions to @siblings_instructions" do
      siblings_instructions = stub_model(Sibling::Instruction)
      Sibling::Instruction.stub(:order) { [siblings_instructions] }
      get :index
      expect(assigns(:siblings_instructions)).to eq([siblings_instructions])
    end
  end
end
