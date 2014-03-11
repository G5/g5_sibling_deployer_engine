class Sibling < ActiveRecord::Base
  has_many :deploys
  has_many :instructions, through: :deploys

  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true
  validates :git_repo, presence: true
  validates :heroku_repo, presence: true
  validates :heroku_app_name, presence: true

  class << self
    def main_app_uid
      ENV["MAIN_APP_UID"]
    end

    def main_app_hcard
      Microformats2.parse(main_app_uid).card
    end

    def consume_main_app_hcard
      main_app_hcard.g5_siblings.map do |sibling|
        find_or_create_from_hcard(sibling.format)
      end.compact if main_app_hcard
    rescue OpenURI::HTTPError, "304 Not Modified"
    end

    def async_consume
      Resque.enqueue(SiblingConsumer)
    end

    def find_or_create_from_hcard(hcard)
      find_or_create_by_uid(hcard.uid.to_s) do |sibling|
        sibling.name = hcard.name.to_s
        sibling.git_repo = hcard.g5_git_repo.to_s
        sibling.heroku_repo = hcard.g5_heroku_repo.to_s
        sibling.heroku_app_name = hcard.g5_heroku_app_name.to_s
      end
    end

    def deploy_all(manual=true, instruction_id=nil)
      all.each { |sibling| sibling.deploy(instruction_id) }
    end
  end

  def deploy(instruction_id=nil)
    self.deploys.create!(
      instruction_id: instruction_id,
      manual: !instruction_id,
      git_repo: git_repo,
      heroku_repo: heroku_repo,
      heroku_app_name: heroku_app_name
    )
  end
end
