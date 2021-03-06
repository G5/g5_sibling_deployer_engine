class Sibling::Deploy < ActiveRecord::Base

  belongs_to :sibling
  belongs_to :instruction

  validates :sibling_id, presence: true
  validates :manual, inclusion: { in: [true, false] }
  validates :git_repo, presence: true
  validates :heroku_repo, presence: true
  validates :heroku_app_name, presence: true

  after_create :async_deploy

  state_machine :initial => :new do
    event :queue do
      transition any => :queued
    end
    event :start do
      transition any => :deploying
    end
    event :fail do
      transition any => :failed
    end
    event :succeed do
      transition any => :succeeded
    end
  end

  scope :manual, -> { where(manual: true) }
  scope :automatic, -> { where(manual: false) }

  def deploy
    start!

    GithubHerokuDeployer.deploy(deployer_options)
    GithubHerokuDeployer.heroku_run("rake db:migrate", deployer_options)

    succeed!
  rescue StandardError => e
    fail!
    raise e
  end

  def deployer_options
    { github_repo: git_repo,
      heroku_repo: heroku_repo,
      heroku_app_name: heroku_app_name }
  end

  def async_deploy
    queue!
    Resque.enqueue(SiblingDeployer, self.id)
  rescue StandardError => e
    fail!
    raise e
  end
end
