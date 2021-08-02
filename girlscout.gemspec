# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'girlscout/version'

Gem::Specification.new do |s|
  s.name        = 'girlscout'
  s.version     = GirlScout::VERSION
  s.date        = '2019-07-05'
  s.summary     = 'Integrate your support tooling with HelpScout API v2'
  s.description = 'Provides integration with HelpScout REST API v2'
  s.authors     = ['Phureewat Aphibansri <phureewat@omise.co>', 'Chakrit Wichian <chakrit@omise.co>']
  s.homepage    = 'https://github.com/omise/girlscout'
  s.license     = 'MIT'

  s.files         = `git ls-files -z lib`.split("\x0")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'excon', '~>0.85'
  s.add_runtime_dependency 'json', '>=1.8'

  s.add_development_dependency 'bundler', '~>2.0'
  s.add_development_dependency 'guard', '~>2.14'
  s.add_development_dependency 'guard-minitest', '~>2.4'
  s.add_development_dependency 'minitest', '~>5.11'
  s.add_development_dependency 'minitest-reporters', '~>1.3'
  s.add_development_dependency 'overcommit', '~>0.46'
  s.add_development_dependency 'pry', '~>0.11'
  s.add_development_dependency 'rake', '~>12.3'
  s.add_development_dependency 'rubocop', '~>0.58'
  s.add_development_dependency 'vcr', '~>5.0'
end
