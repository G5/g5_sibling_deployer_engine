class SiblingDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(id)
    logger.info "Starting sibling deploy..."

    SiblingDeploy.find(id).deploy

    logger.info "Succeeded deploying siblings."
  rescue StandardError => e
    logger.info "Failed deploying siblings."
    raise e
  end
end
