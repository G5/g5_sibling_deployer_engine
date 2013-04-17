require "spec_helper"

describe SiblingConsumer do
  describe ".perform" do
    it "consumes entry feed" do
      Sibling.should_receive(:consume_main_app_hcard).once
      SiblingConsumer.perform
    end
    it "raises error when there is no Sibling.main_app_uid" do
      lambda { SiblingConsumer.perform }.should raise_error(TypeError)
    end
    it "returns true when there is a Sibling.main_app_uid" do
      Sibling.stub(:main_app_uid).and_return("spec/support/g5-configurator-app.html")
      SiblingConsumer.perform.should be_true
    end
    it "does not swallow errors" do
      Sibling.stub(:consume_main_app_hcard).and_raise(StandardError.new("Foo"))
      lambda { SiblingConsumer.perform }.should raise_error(StandardError, "Foo")
    end
  end
end
