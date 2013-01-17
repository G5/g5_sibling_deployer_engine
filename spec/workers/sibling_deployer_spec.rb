require "spec_helper"

describe SiblingDeployer do
  describe ".perform" do
    it "deploys entry feed" do
      sibling_deploy = mock(Sibling::Deploy)
      Sibling::Deploy.stub(:find) { sibling_deploy }
      sibling_deploy.should_receive(:deploy).once
      SiblingDeployer.perform(1)
    end
    it "does not swallow errors" do
      sibling_deploy = mock(Sibling::Deploy)
      Sibling::Deploy.stub(:find) { sibling_deploy }
      sibling_deploy.stub(:deploy).and_raise(StandardError.new("Foo"))
      lambda { SiblingDeployer.perform(1) }.should raise_error(StandardError, "Foo")
    end
  end
end
