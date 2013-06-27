$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

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
