# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << './lib'
  t.libs << './test'
  t.pattern = 'test/*_test.rb'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test
