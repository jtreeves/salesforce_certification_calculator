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

# --- Ran 106 tests in 0.013781s on 7/30/22 --- OK --- #