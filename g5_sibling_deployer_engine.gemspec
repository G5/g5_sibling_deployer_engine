# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "g5_sibling_deployer_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name          = "g5_sibling_deployer_engine"
  gem.version       = G5SiblingDeployerEngine::VERSION
  gem.authors       = ["Jessica Lynn Suttles"]
  gem.email         = ["jlsuttles@gmail.com"]
  gem.description   = "Rails Engine for G5 sibling deployers"
  gem.summary       = "Rails Engine for G5 sibling deployers"
  gem.homepage      = "https://github.com/G5/g5_sibling_deployer_engine"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", "~> 4.1.4"
  gem.add_dependency "state_machine", "~> 1.2.0"
  gem.add_dependency "heroku_resque_autoscaler", "~> 0.1.0"
  gem.add_dependency "microformats2", "~> 2.0.0"
  gem.add_dependency "github_heroku_deployer", "~> 0.4"
  gem.add_dependency "pg", "~> 0.18.1"

  gem.add_development_dependency "sqlite3", "~> 1.3.6"
  gem.add_development_dependency "simplecov", "~> 0.8.2"
  gem.add_development_dependency "rspec-rails", "~> 2.14.1"
  gem.add_development_dependency "guard-rspec", "~> 4.2.8"
  gem.add_development_dependency "spork", "~> 0.9.2"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.2"
end
