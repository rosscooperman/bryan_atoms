PROJECT_ROOT = File.expand_path('..', __dir__)
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

require 'pry'
require 'pry-byebug'

require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  config.default_formatter = 'doc'
  config.mock_with :rspec
end


# require 'simplecov'
# SimpleCov.start do
#   add_filter '/vendor'
#   add_filter '/lib/tasks'
# end

# RSpec.configure do |config|
#   config.expect_with :rspec do |expectations|
#     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
#   end

#   config.mock_with :rspec do |mocks|
#     mocks.verify_partial_doubles = true
#     mocks.verify_doubled_constant_names = true
#   end

#   config.disable_monkey_patching!
#   config.filter_run_when_matching :focus if ENV['CI'] != 'true'

#   config.default_formatter = 'doc' if config.files_to_run.one?

#   config.profile_examples = 10
#   config.order = :random
#   Kernel.srand config.seed
# end
