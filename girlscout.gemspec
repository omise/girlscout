lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'girlscout'
  s.version     = '0.1.4'
  s.date        = '2015-12-16'
  s.summary     = 'Integrate your support tooling with HelpScout API.'
  s.description = 'Provides integration with HelpScout REST API.'
  s.authors     = ['Chakrit Wichian']
  s.email       = 'chakrit@omise.co'
  s.homepage    = 'https://www.omise.co'
  s.license     = 'MIT'

  s.files         = `git ls-files -z lib`.split("\x0")
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rest-client', '~>1.8'
  s.add_runtime_dependency 'json', '~>1.8'

  s.add_development_dependency 'rake', '~>10.4'
  s.add_development_dependency 'pry', '~>0.10'
  s.add_development_dependency 'webmock', '~>1.22'
  s.add_development_dependency 'bundler', '~>1.12'
  s.add_development_dependency 'minitest', '~>5.8'
  s.add_development_dependency 'guard', '~>2.13'
  s.add_development_dependency 'guard-minitest', '~>2.4'
end
