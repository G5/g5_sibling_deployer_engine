class SiblingConsumer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :consumer

  def self.perform(id)
    logger.info "Starting sibling consumption..."

    Sibling.consume

    logger.info "Succeeded consuming siblings."
  rescue StandardError => e
    logger.info "Failed consuming siblings."
    raise e
  end
end
