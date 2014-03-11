require "spec_helper"

describe SiblingDeployer do
  before do
    @sibling_deploy = mock(Sibling::Deploy)
    Sibling::Deploy.stub(:find) { @sibling_deploy }
  end

  describe ".perform" do
    it "deploys entry feed" do
      @sibling_deploy.should_receive(:deploy).once
      SiblingDeployer.perform(1)
    end

    it "does not swallow errors" do
      @sibling_deploy.stub(:deploy).and_raise(StandardError.new("Foo"))
      lambda { SiblingDeployer.perform(1) }.should raise_error(StandardError, "Foo")
    end
  end

  describe "when an exception is raised" do
    before do
     @sibling_deployer = SiblingDeployer.new(1)
    end

    it "retries 0 times when Exception" do
      @sibling_deploy.stub(:deploy).and_raise(Exception)
      expect { @sibling_deployer.perform }.to raise_error(Exception)
      expect(@sibling_deployer.retries).to eq 0
    end

    it "retries 3 times when GithubHerokuDeployer::CommandException" do
      @sibling_deploy.stub(:deploy).and_raise(GithubHerokuDeployer::CommandException)
      expect { @sibling_deployer.perform }.to raise_error(GithubHerokuDeployer::CommandException)
      expect(@sibling_deployer.retries).to eq 3
    end

    it "retries 3 times when Heroku::API::Errors::ErrorWithResponse" do
      pending "Not sure how to raise this error"
      @sibling_deploy.stub(:deploy).and_raise(Heroku::API::Errors::ErrorWithResponse.new(nil, ))
      expect { @sibling_deployer.perform }.to raise_error(Heroku::API::Errors::ErrorWithResponse)
      expect(@sibling_deployer.retries).to eq 3
    end
  end
end
