require 'spec_helper'

describe Sibling::Instruction do
  before :each do
    stub_const("Sibling::MAIN_APP_UID", "spec/support/main_app.html")
    stub_const("Sibling::Instruction::FEED_URL", "spec/support/instructions.html")
    Sibling.consume
  end

  describe ".feed" do
    it "is an Array of h-entry" do
      Sibling::Instruction.feed.should be_an_instance_of G5HentryConsumer::HFeed
    end
  end

  describe ".consume_feed" do
    it "creates instructions that target me" do
      Sibling.any_instance.stub(:uid).and_return("http://g5-configurator.dev/apps/16")
      expect { Sibling::Instruction.consume_feed }.to(
        change(Sibling::Instruction, :count).by(1))
    end
    it "does not create intructions that do not target me" do
      Sibling.any_instance.stub(:uid).and_return("http://g5-configurator.dev/apps/17")
      expect { Sibling::Instruction.consume_feed }.to(
        change(Sibling::Instruction, :count).by(0))
    end
    it "creates instructions that target me" do
      Sibling::Instruction.stub(:last_modified_at) { Time.parse("11:32pm on December  10, 2012") }
      expect { Sibling::Instruction.consume_feed }.to(
        change(Sibling::Instruction, :count).by(0))
    end
    it "swallows http errors" do
      Sibling::Instruction.stub(:feed).and_raise(OpenURI::HTTPError.new("304 Not Modified", nil))
      Sibling::Instruction.consume_feed.should == true
    end
  end

  describe ".async_consume_feed" do
    it "queues consumer" do
      Resque.should_receive(:enqueue).with(SiblingInstructionConsumer)
      Sibling::Instruction.async_consume_feed
    end
  end

  describe ".find_or_create_from_hentry" do
    before :each do
      @hentry = Sibling::Instruction.feed.entries.first
    end
    it "creates Instruction if it does not already exist" do
      expect { Sibling::Instruction.find_or_create_from_hentry(@hentry) }.to(
        change(Sibling::Instruction, :count).by(1))
    end
    it "finds Instruction if it already exists" do
      Sibling::Instruction.find_or_create_from_hentry(@hentry)
      expect { Sibling::Instruction.find_or_create_from_hentry(@hentry) }.to(
        change(Sibling::Instruction, :count).by(0))
    end
  end

  describe ".targets_me?" do
    it "is true when main app uid" do
      Sibling::Instruction.targets_me?(nil).should == false
    end
    it "is false when not main app uid" do
      Sibling::Instruction.targets_me?(Sibling.main_app.uid).should == true
    end
  end
end
