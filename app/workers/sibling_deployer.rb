class SiblingDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer
  attr_reader :app, :retries

  def self.perform(app_id)
    self.new(app_id).perform
  end

  def initialize(app_id)
    @app = Sibling::Deploy.find(app_id)
    @retries = 0
  end

  def perform
    Rails.logger.info "Starting deploying sibling..."
    @app.deploy
    Rails.logger.info "Succeeded deploying sibling."
  rescue GithubHerokuDeployer::CommandException,
         Heroku::API::Errors::ErrorWithResponse => e
    if should_retry?
      Rails.logger.info "Retrying deploying sibling..."
      increment_retries
      retry
    else
      raise e
    end
  rescue StandardError => e
    Rails.logger.info "Failed deploying sibling."
    raise e
  end

  def should_retry?
    @retries < 3
  end

  def increment_retries
    @retries += 1
  end
end
