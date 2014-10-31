class SiblingInstructionConsumer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :consumer

  def self.perform
    Rails.logger.info "Starting instruction feed consumption from #{Sibling::Instruction.feed_url}"

    Sibling::Instruction.consume_feed

    Rails.logger.info "Succeeded consuming instruction feed."
  rescue StandardError => e
    Rails.logger.info "Failed consuming instruction feed."
    raise e
  end
end
