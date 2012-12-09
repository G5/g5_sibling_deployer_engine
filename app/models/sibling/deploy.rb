class Sibling::Deploy < ActiveRecord::Base
  attr_accessible :sibling_id, :instruction_id, :manual, :state
  attr_accessible :git_repo, :heroku_repo, :heroku_app_name

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
      transition :new => :queued
    end
    event :start do
      transition :queued => :deploying
      transition :new => :deploying
    end
    event :fail do
      transition :deploying => :failed
    end
    event :succeed do
      transition :deploying => :succeeded
    end
  end

  scope :manual, where(manual: true)
  scope :automatic, where(manual: false)

  def deploy
    deploy!

    GithubHerokuDeployer.deploy(
      git_repo: git_repo,
      heroku_repo: heroku_repo,
      heroku_app_name: heroku_app_name
    )

    succeed!
  rescue StandardError => e
    fail!
    raise e
  end

  def async_deploy
    queue!
    Resque.enqueue(SiblingDeployer, self.id)
  end
end
