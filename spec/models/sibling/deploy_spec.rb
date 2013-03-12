require 'spec_helper'

describe Sibling::Deploy do
  before :each do
    Sibling.stub(:main_app_uid).and_return("spec/support/g5-configurator-app.html")
    Sibling.consume_main_app_hcard

    @deploy = Sibling::Deploy.create!(
      sibling_id: Sibling.first.id,
      manual: false,
      git_repo: "git@github",
      heroku_repo: "git@heroku",
      heroku_app_name: "mock"
    )
  end
  subject { @deploy }

  it { should be_valid }

  describe "#async_deploy" do
    before :each do
      Resque.stub(:enqueue)
    end
    it "queues deploy" do
      @deploy.stub(:queue!)
      Resque.should_receive(:enqueue).once
      @deploy.async_deploy
    end
    it "changes state to queued" do
      @deploy.update_attributes(state: "new")
      expect { @deploy.async_deploy }.to change(@deploy, :state).to("queued")
    end
    it "does not swallow errors" do
      Resque.stub(:enqueue).and_raise(StandardError.new("Foo"))
      lambda { @deploy.async_deploy }.should raise_error(StandardError, "Foo")
    end
  end

  describe "#deploy" do
    before :each do
      GithubHerokuDeployer.stub(:deploy)
    end
    it "deploys" do
      GithubHerokuDeployer.should_receive(:deploy)
      @deploy.deploy
    end
    it "changes state to succeeded" do
      expect { @deploy.deploy }.to change(@deploy, :state).to("succeeded")
    end
    it "does not swallow errors" do
      GithubHerokuDeployer.stub(:deploy).and_raise(StandardError.new("Foo"))
      lambda { @deploy.deploy }.should raise_error(StandardError, "Foo")
    end
  end
end
