$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pathname'
require 'faker'

EXAMPLE_DATA = Pathname.new(__FILE__).dirname + 'data'

if ENV['TRAVIS'] == 'true'
  require 'coveralls'
  Coveralls.wear!
else
  begin
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
    warn "Unable to load simplecov; skipping coverage report"
  end
end

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.filter_run :focus => true
end
