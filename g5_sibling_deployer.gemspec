# -*- encoding: utf-8 -*-
require File.expand_path('../lib/g5_sibling_deployer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jessica Lynn Suttles"]
  gem.email         = ["jlsuttles@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "g5_sibling_deployer"
  gem.require_paths = ["lib"]
  gem.version       = G5SiblingDeployer::VERSION

  gem.add_dependency "rails", "~> 3.2.0"
  gem.add_dependency "state_machine", "~> 1.1.2"
  gem.add_dependency "heroku_resque_autoscaler", "~> 0.1.0"
  gem.add_dependency "g5_hentry_consumer", "~> 0.2.6"
  gem.add_dependency "github_heroku_deployer", "~> 0.2.0"
  
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "guard-rspec", "~> 2.1.0"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.2"
  gem.add_development_dependency "debugger", "~> 1.2.1"
end
