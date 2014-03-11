require 'rubygems'
require 'spork'

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  end

  ENV["RAILS_ENV"] ||= 'test'
  # Load dummy app
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
  end

  Spork.trap_method(Rails::Application, :eager_load!)
  # Load dummy app
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)

  # Show all of the backtraces
  Rails.backtrace_cleaner.remove_silencers!
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  end
end
