require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)
require 'pry'
require 'find'
require 'girlscout'
require 'minitest/autorun'
require 'webmock'

FIXTURES_PATH = File.absolute_path("#{File.dirname(__FILE__)}/fixtures")
TEST_KEY = "f26dbbb12d15cacd73150c119ba7b31a54f83b59"

def setup_fixtures
  Find.find(FIXTURES_PATH).select { |f| File.file?(f) }.each do |path|
    body = File.read(path)

    relpath = path.slice(FIXTURES_PATH.length + 1, 999)
    method, basename = File.basename(relpath).split('-')

    url = relpath.sub("/#{method}-", "/")
    url = "https://#{url}"
    WebMock.stub_request(method.to_sym, url).to_return(status: 200, body: body)
  end
end

WebMock.enable!
WebMock.stub_request(:get, "https://www.example.com").to_return(status: 200, body: "hello")
WebMock.disable_net_connect!
setup_fixtures

require 'fake_rest_resource'
require 'girlscout_test'

