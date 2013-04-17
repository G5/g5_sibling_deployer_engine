class SiblingConsumer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :consumer

  def self.perform
    Rails.logger.info "Starting sibling consumption..."

    Sibling.consume_main_app_hcard

    Rails.logger.info "Succeeded consuming siblings."
  rescue StandardError => e
    Rails.logger.info "Failed consuming siblings."
    raise e
  end
end
