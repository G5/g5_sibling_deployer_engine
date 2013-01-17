require "spec_helper"

describe SiblingConsumer do
  describe ".perform" do
    it "consumes entry feed" do
      Sibling.should_receive(:consume).once
      SiblingConsumer.perform
    end
    it "does not swallow errors" do
      Sibling.stub(:consume).and_raise(StandardError.new("Foo"))
      lambda { SiblingConsumer.perform }.should raise_error(StandardError, "Foo")
    end
  end
end
