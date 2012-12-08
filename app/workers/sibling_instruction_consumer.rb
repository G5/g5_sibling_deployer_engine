class SiblingInstructionConsumer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :consumer

  def self.perform
    logger.info "Starting instruction feed consumption..."

    Sibling::Instruction.consume_feed

    logger.info "Succeeded consuming instruction feed."
  rescue StandardError => e
    logger.info "Failed consuming instruction feed."
    raise e
  end
end
