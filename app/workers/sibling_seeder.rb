class SiblingSeeder
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :seeder

  def self.perform(id)
    logger.info "Starting sibling seed..."

    Sibling.seed

    logger.info "Succeeded seeding siblings."
  rescue StandardError => e
    logger.info "Failed seeding siblings."
    raise e
  end
end
