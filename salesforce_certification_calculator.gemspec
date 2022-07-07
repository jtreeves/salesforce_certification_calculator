Gem::Specification.new do |s|
    s.name = "salesforce_certification_calculator"
    s.version = "0.0.1"
    s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["Jackson Reeves"]
    s.date = %q{2022-07-06}
    s.description = %q{A simple hello world gem}
    s.email = %q{jr@jacksonreeves.com}
    s.files = ["Rakefile", "lib/salesforce_certification_calculator.rb", "lib/salesforce_certification_calculator/exams.rb", "lib/salesforce_certification_calculator/math.rb"]
    s.test_files = ["test/test_salesforce_certification_calculator.rb", "test/test_exams.rb", "test/test_math.rb"]
    s.require_paths = ["lib"]
    s.rubygems_version = %q{1.6.2}
    s.license = "MIT"
    s.summary="Calculate cumulative percentage from Salesforce certification section results"
    s.website="https://github.com/jtreeves/salesforce_certification_calculator"
end