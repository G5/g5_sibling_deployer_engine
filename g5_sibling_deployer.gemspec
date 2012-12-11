# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "g5_sibling_deployer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name          = "g5_sibling_deployer"
  gem.version       = G5SiblingDeployer::VERSION
  gem.authors       = ["Jessica Lynn Suttles"]
  gem.email         = ["jlsuttles@gmail.com"]
  gem.description   = "Rails Engine for G5 sibling deployers" 
  gem.summary       = "Rails Engine for G5 sibling deployers"
  gem.homepage      = "https://github.com/g5search/g5_sibling_deployer"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", "~> 3.2.7"
  gem.add_dependency "state_machine", "~> 1.1.2"
  gem.add_dependency "heroku_resque_autoscaler", "~> 0.1.0"
  gem.add_dependency "g5_hentry_consumer", "~> 0.2.7"
  gem.add_dependency "github_heroku_deployer", "~> 0.2.0"
  
  gem.add_development_dependency "sqlite3", "~> 1.3.6"
  gem.add_development_dependency "rspec-rails", "~> 2.12.0"
  gem.add_development_dependency "debugger", "~> 1.2.1"
end
