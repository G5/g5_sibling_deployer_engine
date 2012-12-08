# Configure RSpec
RSpec.configure do |config|
  config.color = true
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

# Load dummy app
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# Show all of the backtraces
Rails.backtrace_cleaner.remove_silencers!
