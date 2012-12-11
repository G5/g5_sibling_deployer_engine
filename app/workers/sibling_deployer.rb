class SiblingDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(id)
    Rails.logger.info "Starting sibling deploy..."

    Sibling::Deploy.find(id).deploy

    Rails.logger.info "Succeeded deploying siblings."
  rescue StandardError => e
    Rails.logger.info "Failed deploying siblings."
    raise e
  end
end
