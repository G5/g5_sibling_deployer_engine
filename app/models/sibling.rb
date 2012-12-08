class Sibling < ActiveRecord::Base
  MAIN_APP_UID = ENV["MAIN_APP_UID"]

  attr_accessible :uid, :name, :git_repo, :heroku_repo, :heroku_app_name, :main_app

  has_many :deploys
  has_many :instructions, through: :deploys


  class << self
    def microformat_app(path_or_url=MAIN_APP_UID)
      G5HentryConsumer::EG5App.parse(path_or_url).first
    end

    def seed(path_or_url=MAIN_APP_UID)
      main_app = microformat_app
      find_or_create_from_microformat(main_app, true)
      main_app.siblings.each do |app|
        find_or_create_from_microformat(app)
      end.compact
    end

    def find_or_create_from_microformat(app, main_app=false)
      find_or_create_by_uid(
        uid: app.uid,
        main_app: main_app,
        name: app.name.first,
        git_repo: app.git_repo.first,
        heroku_repo: app.heroku_repo.first,
        heroku_app_name: app.heroku_app_name.first
      )
    end

    def deploy_all(manual=true, instruction_id=nil)
      not_main_app.map { |sibling| sibling.deploy(instruction_id) }
    end
  end

  scope :main_app, where(main_app: true).first
  scope :not_main_app, where(main_app: false)

  def deploy(manual=true, instruction_id=nil)
    # raise G5SiblingDeployer::DeployError.new("You can't deploy yourself!") if main_app?
    self.deploys.create!(
      instruction_id: instruction_id,
      manual: manual,
      git_repo: git_repo,
      heroku_repo: heroku_repo,
      heroku_app_name: heroku_app_name
    )
  end
end