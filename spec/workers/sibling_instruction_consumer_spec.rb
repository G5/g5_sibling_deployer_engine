require "spec_helper"

describe SiblingInstructionConsumer do
  describe ".perform" do
    it "consumes entry feed" do
      Sibling::Instruction.stub(:consume_feed)
      Sibling::Instruction.should_receive(:consume_feed).once
      SiblingInstructionConsumer.perform
    end
    it "does not swallow errors" do
      Sibling::Instruction.stub(:consume_feed).and_raise(StandardError.new("Foo"))
      lambda { SiblingInstructionConsumer.perform }.should raise_error(StandardError, "Foo")
    end
  end
end
