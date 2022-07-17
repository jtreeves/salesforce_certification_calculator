require "yard"
require "rake/testtask"

YARD::Rake::YardocTask.new do |t|
    t.files   = ["lib/**/*.rb"]
end

Rake::TestTask.new do |t|
    t.libs << "test"
end

desc "Run tests"
task default: :test

# --- Ran 85 tests in 0.003641s on 7/16/22 --- OK --- #