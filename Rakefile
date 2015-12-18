require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << './lib'
  t.libs << './test'
  t.pattern = "test/*_test.rb"
  t.test_files = FileList["test/**/test_*.rb"]
end

task default: :test
