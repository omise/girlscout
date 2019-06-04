# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'girlscout/version'

Gem::Specification.new do |s|
  s.name        = 'girlscout'
  s.version     = GirlScout::VERSION
  s.date        = '2015-12-16'
  s.summary     = 'Integrate your support tooling with HelpScout API.'
  s.description = 'Provides integration with HelpScout REST API.'
  s.authors     = ['Chakrit Wichian', 'Phureewat Aphibansri']
  s.email       = 'phureewat@omise.co'
  s.homepage    = 'https://github.com/omise/girlscout'
  s.license     = 'MIT'

  s.files         = `git ls-files -z lib`.split("\x0")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'excon', '~>0.62'
  s.add_runtime_dependency 'json', '>=2.1'

  s.add_development_dependency 'bundler', '~>2.0'
  s.add_development_dependency 'guard', '~>2.14'
  s.add_development_dependency 'guard-minitest', '~>2.4'
  s.add_development_dependency 'minitest', '~>5.11'
  s.add_development_dependency 'minitest-reporters', '~>1.3'
  s.add_development_dependency 'overcommit', '~>0.46'
  s.add_development_dependency 'pry', '~>0.11'
  s.add_development_dependency 'rake', '~>12.3'
  s.add_development_dependency 'rubocop', '~>0.58'
  s.add_development_dependency 'timecop', '~>0.9'
  s.add_development_dependency 'vcr', '~>4.0'
end
