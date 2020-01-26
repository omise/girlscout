desc 'Load gem inside irb console'
task :console do
  require 'irb'
  require 'irb/completion'
  require File.join(__FILE__, '../../lib/girlscout')
  ARGV.clear
  IRB.start
end
task c: %w[console]
