require 'rake/testtask'

task :default => :test

def command?(command)
  system("type #{command} > /dev/null 2>&1")
end

#
# Tests
#

if command? :turn
  desc "Run tests"
  task :test do
    suffix = "-n #{ENV['TEST']}" if ENV['TEST']
    sh "turn -Ilib:. test/*.rb #{suffix}"
  end
else
  Rake::TestTask.new do |t|
    t.libs << 'lib'
    t.libs << '.'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = false
  end
end

#
# Development
#

desc "Drop to irb."
task :console do
  exec "irb -I lib -rkss"
end

