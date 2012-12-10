require 'spec_helper'

describe Sibling::Deploy do

  describe "#async_deploy" do
    before :each do
      @deploy = Sibling::Deploy.new
      Resque.stub(:enqueue)
    end
    it "queues deploy" do
      @deploy.stub(:queue!)
      Resque.should_receive(:enqueue).exactly(1).times
      @deploy.async_deploy
    end
    it "changes state to queued" do
      lambda { @deploy.async_deploy }.should
        change(@deploy, :state).from(:new).to(:queued)
    end
  end

  describe "#deploy" do
    before :each do
      @deploy = Sibling::Deploy.new
      GithubHerokuDeployer.stub(:deploy)
    end
    it "changes state to deploying" do
      lambda { @deploy.deploy }.should
        change(@deploy, :state).from(:new).to(:deploying)
    end
    it "deploys" do
      @deploy.stub(:start!)
      @deploy.stub(:succeed!)
      GithubHerokuDeployer.should_receive(:deploy)
      @deploy.deploy
    end
    it "changes state to succeeded" do
      lambda { @deploy.deploy }.should
        change(@deploy, :state).from(:deploying).to(:succeeded)
    end
    it "changes state to failed" do
      lambda { @deploy.deploy }.should
        change(@deploy, :state).from(:deploying).to(:failed)
    end
  end
end
