require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)
require 'pry'
require 'find'
require 'girlscout'
require 'minitest/autorun'
require 'webmock'

FIXTURES_PATH = File.absolute_path("#{File.dirname(__FILE__)}/fixtures")
TEST_KEY = "04f46582b440fc579d96fa50294131940158b089"

def setup_fixtures
  Find.find(FIXTURES_PATH).select { |f| File.file?(f) }.each do |path|
    body = File.read(path)

    relpath = path.slice(FIXTURES_PATH.length + 1, 999)
    method, basename = File.basename(relpath).split('-')

    url = relpath.sub("/#{method}-", "/")
    url = "https://#{TEST_KEY}:X@#{url}"
    WebMock.stub_request(method.to_sym, url).to_return(status: 200, body: body)
  end
end

WebMock.enable!
WebMock.stub_request(:get, "https://www.example.com").to_return(status: 200, body: "hello")

setup_fixtures
unless ENV["RECORD"]
  WebMock.disable_net_connect!
else
  WebMock.allow_net_connect!
  WebMock.after_request(real_requests_only: true) do |signature, response|
    require 'zlib'
    require 'stringio'

    decompressed_body = Zlib::GzipReader.new(StringIO.new(response.body)).read rescue response.body
    puts
    puts "================="
    puts "Should stub request: #{signature}"
    puts decompressed_body
    puts "================="
  end
end

class FakeRestResource
  attr_accessor :url
  attr_accessor :options
  attr_accessor :result
  attr_accessor :get_params

  def initialize(url, options={})
    @url = url
    @options = options
  end

  def [](path)
    FakeRestResource.new("#{@url}#{path}", @options)
  end

  def get(options=nil)
    @get_params = options[:headers][:params] rescue nil
    result
  end

  [:put, :post, :patch, :delete].each do |name|
    attr_accessor :"#{name}_payload"
    attr_accessor :"#{name}_params"

    define_method(name.to_s) do |payload=nil, options=nil|
      params = options[:headers][:params] rescue nil

      instance_variable_set("@#{name}_payload", payload)
      instance_variable_set("@#{name}_params", params)
      result
    end
  end
end

