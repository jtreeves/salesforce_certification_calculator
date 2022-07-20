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

# --- Ran 103 tests in 0.014065s on 7/20/22 --- OK --- #