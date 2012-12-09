require 'spec_helper'

describe Sibling do
  before :each do
    stub_const("Sibling::MAIN_APP_UID", "spec/support/main_app.html")
  end

  describe ".microformat_app" do
    it "is a e-g5-app" do
      Sibling.microformat_app.should be_an_instance_of G5HentryConsumer::EG5App
    end
  end

  describe ".consume" do
    before :each do
      Sibling.consume
    end
    it "creates main app" do
      Sibling.main_app.should be_present
    end
    it "creates sibling apps" do
      Sibling.not_main_app.should be_present
    end
  end

  describe ".find_or_create_from_microformat" do
    before :each do
      @app = Sibling.microformat_app
    end
    it "creates Sibling if it does not already exist" do
      lambda { Sibling.find_or_create_from_microformat(@app) }.should
        change(Sibling, :count).by(1)
    end
    it "finds Sibling if it already exists" do
      Sibling.find_or_create_from_microformat(@app)
      lambda { Sibling.find_or_create_from_microformat(@app) }.should
        change(Sibling, :count).by(0)
    end
  end

  describe ".deploy_all" do
    before :each do
      Sibling.consume
      Sibling.any_instance.stub(:deploy)
    end
    it "deploys sibling apps" do
      Sibling.any_instance.should_receive(:deploy).exactly(1).times
      Sibling.deploy_all
    end
  end

  describe ".main_app" do
    it "does not return non main apps" do
      sibling = Sibling.create!(main_app: false)
      Sibling.main_app.should be_nil
    end
    it "returns main apps" do
      sibling = Sibling.create!(main_app: true)
      Sibling.main_app.should eq(sibling)
    end
  end

  describe ".not_main_app" do
    it "returns non main apps" do
      sibling = Sibling.create!(main_app: false)
      Sibling.not_main_app.should eq([sibling])
    end
    it "does not return main apps" do
      sibling = Sibling.create!(main_app: true)
      Sibling.not_main_app.should be_empty
    end
  end

  describe "#deploy" do
    before :each do
      Sibling::Deploy.any_instance.stub(:async_deploy)
      Sibling.consume
      @main_app = Sibling.main_app
      @sibling = Sibling.not_main_app.first
    end
    it "creates a deploy" do
      lambda { @sibling.deploy }.should
        change(Sibling::Deploy, :count).by(1)
    end
    it "does not create deploy if called on main_app" do
      lambda { @main_app.deploy }.should
        change(Sibling::Deploy, :count).by(0)
    end
    it "creates manual deploys when instruction is not present" do
      lambda { @sibling.deploy }.should
        change(Sibling::Deploy.manual, :count).by(1)
    end
    it "creates automatic deploys when instruction is present" do
      instruction = mock Sibling::Instruction
      lambda { @sibling.deploy(instruction.id) }.should
        change(Sibling::Deploy.automatic, :count).by(1)
    end
  end
end
