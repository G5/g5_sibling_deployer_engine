class Sibling::Instruction < ActiveRecord::Base
  FEED_URL = "http://g5-configurator.herokuapp.com/instructions"

  attr_accessible :uid, :name, :published_at

  has_many :deploys
  has_many :siblings, through: :deploys

  validates :uid, uniqueness: true
  validates :name, presence: true
  validates :published_at, presence: true

  after_save :deploy

  class << self
    def feed(path_or_url=FEED_URL)
      G5HentryConsumer.parse(path_or_url)
    end

    def consume_feed(path_or_url=FEED_URL)
      feed(path_or_url).entries.map do |hentry|
        if instruction_targets_me?(hentry)
          consume_hentry(hentry)
        end
      end.compact
    end

    def async_consume_feed
      Resque.enqueue(SiblingInstructionConsumer)
    end

    def instruction_targets_me?(hentry)
      if hentry.nil? || hentry.is_a?(String)
        hentry == Sibling.main_app.uid
      else
        targets = hentry.content.first.targets
        targets && targets.include?(Sibling.main_app.uid)
      end
    end

    def find_or_create_from_hentry(hentry)
      find_or_create_by_uid(
        uid: hentry.bookmark,
        name: hentry.name.first,
        published_at: hentry.published_at.first
      )
    end
  end # class << self

  private

  def deploy
    Sibling.deploy_all(self.id)
  end
end
