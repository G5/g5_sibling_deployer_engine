require 'open-uri'

class Sibling::Instruction < ActiveRecord::Base

  has_many :deploys
  has_many :siblings, through: :deploys

  validates :uid, uniqueness: true
  validates :name, presence: true
  validates :published_at, presence: true

  after_save :deploy

  class << self
    def feed_url
      ENV["G5_CONFIGURATOR_FEED_URL"]
    end

    def feed
      Microformats2.parse(feed_url)
    end

    def consume_feed
      feed.entries.map do |hentry|
        find_or_create_from_hentry(hentry) if targets_me?(hentry)
      end.compact
    rescue OpenURI::HTTPError => e
      raise e unless /304 Not Modified/ =~ e.message
    end

    def async_consume_feed
      Resque.enqueue(SiblingInstructionConsumer)
    end

    def targets_me?(hentry)
      targets = instruction(hentry).g5_targets.map { |t| t.format.uid.to_s }
      targets && targets.include?(Sibling.main_app_uid)
    end

    def instruction(hentry)
      Microformats2.parse(hentry.content.to_s).card
    end

    def find_or_create_from_hentry(hentry)
      find_or_create_by(uid: hentry.uid.to_s) do |instruction|
        hcard = instruction(hentry)
        instruction.name = hcard.name.to_s
        instruction.published_at = hentry.updated.value
      end
    end
  end # class << self

  private

  def deploy
    Sibling.deploy_all(true, self.id)
  end
end
