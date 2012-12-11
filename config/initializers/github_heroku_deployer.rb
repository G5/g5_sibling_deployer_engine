GithubHerokuDeployer.configure do |config|
  config.heroku_api_key  = ENV["HEROKU_API_KEY"]
  config.heroku_username = ENV["HEROKU_USERNAME"]
  config.id_rsa          = ENV["ID_RSA"]
  config.logger          = Rails.logger
  config.repo_dir        = File.join(Rails.root, "tmp", "repos")
end
