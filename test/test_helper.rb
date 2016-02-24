if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rocket_model'

require 'minitest/autorun'

RocketModel::Base.configure do |c|
  c.store = {store: "file", path: "test/fixtures/test.pstore"}
end
