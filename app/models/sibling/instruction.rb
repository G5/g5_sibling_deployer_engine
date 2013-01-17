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
      G5HentryConsumer.parse(path_or_url, last_modified_at: last_modified_at)
    end

    def last_modified_at
      scoped.maximum(:created_at)
    end

    def consume_feed(path_or_url=FEED_URL)
      feed(path_or_url).entries.map do |hentry|
        if targets_me?(hentry)
          find_or_create_from_hentry(hentry)
        end
      end.compact
    rescue OpenURI::HTTPError, "304 Not Modified"
      true
    end

    def async_consume_feed
      Resque.enqueue(SiblingInstructionConsumer)
    end

    def find_or_create_from_hentry(hentry)
      find_or_create_by_uid(
        uid: hentry.bookmark,
        name: hentry.name.first,
        published_at: hentry.published_at.first
      )
    end

    def targets_me?(hentry)
      if hentry.nil? || hentry.is_a?(String)
        hentry == Sibling.main_app.uid
      else
        targets = hentry.content.first.targets
        targets && targets.include?(Sibling.main_app.uid)
      end
    end
  end # class << self

  private

  def deploy
    Sibling.deploy_all(true, self.id)
  end
end
