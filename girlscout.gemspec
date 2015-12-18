lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'girlscout'
  s.version     = '0.1.0'
  s.date        = '2015-12-16'
  s.summary     = 'Integrate your support tooling with HelpScout API.'
  s.description = 'Provides integration with HelpScout REST API.'
  s.authors     = ['Chakrit Wichian']
  s.email       = 'chakrit@omise.co'
  s.files       = 'lib/girlscout.rb'
  s.homepage    = 'https://www.omise.co'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'json'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
end
