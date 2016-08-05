require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)
require 'pry'
require 'find'
require 'excon'
require 'vcr'
require 'girlscout'

require 'minitest'
require 'minitest/hell'
require 'minitest/pride'
require 'minitest/autorun'

FIXTURES_PATH = File.absolute_path("#{File.dirname(__FILE__)}/fixtures")
TEST_KEY      = "74c608b61192dd78076fc97af82bbe808415355e"

VCR.configure do |c|
  c.cassette_library_dir = FIXTURES_PATH
  c.default_cassette_options = { record: :new_episodes }
  c.hook_into :excon
end

require 'girlscout_test'
require 'resource_spy'

