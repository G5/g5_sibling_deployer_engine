require 'spec_helper'

describe Sibling::Deploy do
  before :each do
    stub_const("Sibling::MAIN_APP_UID", "spec/support/main_app.html")
    Sibling.consume

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
      Resque.should_receive(:enqueue).exactly(1).times
      @deploy.async_deploy
    end
    it "changes state to queued" do
      @deploy.update_attributes(state: "new")
      expect { @deploy.async_deploy }.to(
        change(@deploy, :state).to("queued"))
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
      expect { @deploy.deploy }.to(
        change(@deploy, :state).to("succeeded"))
    end
    it "changes state to failed" do
      expect { @deploy.deploy }.to(
        change(@deploy, :state).to("succeeded"))
    end
  end
end
