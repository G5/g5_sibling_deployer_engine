require 'spec_helper'

describe Sibling::Instruction do
  before :each do
    Resque.stub(:enqueue)
    Sibling.stub(:main_app_uid).and_return("spec/support/g5-configurator-app.html")
    Sibling::Instruction.stub(:feed_url).and_return("spec/support/g5-configurator-entries.html")
    Sibling.consume_main_app_hcard
    Sibling.stub(:main_app_uid).and_return("http://g5-configurator.dev/apps/g5-chd-1-metro-self-storage")
  end

  describe ".feed" do
    it "returns a Microformats2::Collection" do
      Sibling::Instruction.feed.should be_kind_of Microformats2::Collection
    end
  end
  describe ".consume_feed" do
    it "returns an Array of created ActiveRecord Entries" do
      Sibling::Instruction.consume_feed.first.should be_a_kind_of(Sibling::Instruction)
    end
    it "returns nil if not targeted" do
      Sibling.stub(:main_app_uid).and_return("http://g5-configurator.dev/apps/g5-ch-1-metro-self-storage")
      Sibling::Instruction.consume_feed.first.should be_nil
    end
    it "swallows 304 errors" do
      error = OpenURI::HTTPError.new("304 Not Modified", nil)
      Sibling::Instruction.stub(:find_or_create_from_hentry).and_raise(error)
      Sibling::Instruction.consume_feed.should be_nil
    end
  end
  describe ".async_consume_feed" do
    it "enqueues Sibling::InstructionConsumer" do
      Resque.stub(:enqueue)
      Resque.should_receive(:enqueue).with(SiblingInstructionConsumer)
      Sibling::Instruction.async_consume_feed
    end
  end
  describe ".find_or_create_from_hentry" do
    before do
      @hentry = Sibling::Instruction.feed.entries.second
      @instruction = Sibling::Instruction.instruction(@hentry)
    end
    it "creates an Sibling::Instruction" do
      Sibling::Instruction.destroy_all
      expect { Sibling::Instruction.find_or_create_from_hentry(@hentry) }.to(
        change(Sibling::Instruction, :count).by(1))
    end
    it "creates a Deploy" do
      Sibling::Instruction.destroy_all
      expect { Sibling::Instruction.find_or_create_from_hentry(@hentry) }.to(
        change(Sibling::Deploy, :count).by(1))
    end
  end
  describe ".instruction" do
    before do
      @instruction = Sibling::Instruction.instruction(Sibling::Instruction.feed.entries.second)
    end
    it "has a uid" do
      @instruction.uid.to_s.should == "http://g5-configurator.dev/instructions/5"
    end
    it "has a target uid" do
      @instruction.g5_target.format.uid.to_s.should == "http://g5-configurator.dev/apps/g5-chd-1-metro-self-storage"
    end
  end
end
