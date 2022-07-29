Gem::Specification.new do |s|
    s.name = "salesforce_certification_calculator"
    s.version = "0.1.2"
    s.executables << "salesforce_certification_calculator"
    s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["Jackson Reeves"]
    s.date = %q{2022-07-15}
    s.description = "Calculates cumulative percentage from Salesforce certification section results"
    s.email = %q{jr@jacksonreeves.com}
    s.files = Dir.glob("lib/**/*") + Dir.glob("data/*xml") + %w(README.md Rakefile)
    s.test_files = Dir.glob("test/test_*")
    s.add_runtime_dependency("nokogiri", "~> 1.13")
    s.add_development_dependency("rake", ">= 13.0")
    s.add_development_dependency("yard", ">= 0.9")
    s.add_development_dependency("stringio", ">= 3.0")
    s.add_development_dependency("o_stream_catcher", ">= 0.0.1")
    s.require_paths = ["lib", "data"]
    s.required_ruby_version = ">= 2.0"
    s.rubygems_version = %q{1.6.2}
    s.license = "MIT"
    s.post_install_message = "Thanks for installing the SalesforceCertificationCalculator module!"
    s.summary="Uses linear algebra to determine total scores on exams"
    s.homepage="https://github.com/jtreeves/salesforce_certification_calculator"
end