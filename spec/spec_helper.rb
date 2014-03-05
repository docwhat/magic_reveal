require 'simplecov'
require 'coveralls'

if ENV['TRAVIS'] == 'true'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
end

SimpleCov.command_name 'RSpec'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pathname'
require 'faker'

I18n.enforce_available_locales = true if I18n.respond_to? :enforce_available_locales
EXAMPLE_DATA = Pathname.new(__FILE__).dirname + 'data'

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.filter_run focus: true
end
