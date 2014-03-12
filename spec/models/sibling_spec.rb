require 'spec_helper'

describe Sibling do
  before do
    Sibling.stub(:main_app_uid).and_return("spec/support/g5-configurator-app.html")
  end

  describe ".main_app_hcard" do
    it "returns an HCard" do
      Sibling.main_app_hcard.should be_kind_of(HCard)
    end
  end
  describe ".consume_main_app_hcard" do
    it "returns an Array of created Siblings" do
      Sibling.consume_main_app_hcard.first.should be_a_kind_of(Sibling)
    end
    it "returns nil if no Siblings created" do
      Sibling.stub(:main_app_uid).and_return("spec/support/g5-configurator-no-app.html")
      Sibling.consume_main_app_hcard.should be_nil
    end
    it "swallows 304 errors" do
      error = OpenURI::HTTPError.new("304 Not Modified", nil)
      Sibling.stub(:find_or_create_from_hcard).and_raise(error)
      Sibling.consume_main_app_hcard.should be_nil
    end
  end
  describe ".async_consume" do
    it "enqueues SiblingConsumer" do
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).with(SiblingConsumer)
      Sibling.async_consume
    end
  end
  describe ".find_or_create_from_hcard" do
    before :each do
      @hcard = Sibling.main_app_hcard.g5_sibling.format
    end
    it "creates Sibling if it does not already exist" do
      Sibling.destroy_all
      expect { Sibling.find_or_create_from_hcard(@hcard) }.to(
        change(Sibling, :count).by(1))
    end
    it "finds Sibling if it already exists" do
      Sibling.find_or_create_from_hcard(@hcard)
      expect { Sibling.find_or_create_from_hcard(@hcard) }.to(
        change(Sibling, :count).by(0))
    end
  end
  describe ".deploy_all" do
    before :each do
      Sibling.consume_main_app_hcard
      Sibling.any_instance.stub(:deploy)
    end
    it "deploys sibling apps" do
      Sibling.any_instance.should_receive(:deploy).exactly(1).times
      Sibling.deploy_all
    end
  end
  describe "#deploy" do
    before :each do
      Sibling::Deploy.any_instance.stub(:async_deploy)
      Sibling.consume_main_app_hcard
      @sibling = Sibling.first
    end
    it "creates a deploy" do
      expect { @sibling.deploy }.to(
        change(Sibling::Deploy, :count).by(1))
    end
    it "creates manual deploys when instruction is not present" do
      expect { @sibling.deploy }.to(
        change(Sibling::Deploy.manual, :count).by(1))
    end
  end
end
