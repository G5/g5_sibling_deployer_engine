require 'spec_helper'

describe Sibling::Instruction do
  before :each do
    stub_const("Sibling::MAIN_APP_UID", "spec/support/main_app.html")
    stub_const("Sibling::Instruction::FEED_URL", "spec/support/instructions.html")
  end

  describe ".feed" do
    it "is an Array of h-entry" do
    end
  end

  describe ".consume_feed" do
    it "creates instructions that target me" do
    end
    it "does not create intructions that do not target me" do
    end
  end

  describe ".targets_me?" do
    it "is true when my urn is in the list of targets" do
    end
    it "is false when urn is not in the list of targets" do
    end
  end

  describe ".find_or_create_from_hentry" do
    it "finds Instruction if it already exists" do
    end
    it "creates Instruction if it does not already exist" do
    end
  end

  describe "#deploy" do
    it "deploys all siblings" do
    end
  end
end
