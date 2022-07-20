Gem::Specification.new do |s|
    s.name = "salesforce_certification_calculator"
    s.version = "0.0.1"
    s.executables << "salesforce_certification_calculator"
    s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["Jackson Reeves"]
    s.date = %q{2022-07-15}
    s.description = "Salesforce resource for certifications"
    s.email = %q{jr@jacksonreeves.com}
    s.files = Dir.glob("lib/**/*") + Dir.glob("data/*xml") + %w(README.md Rakefile)
    s.test_files = Dir.glob("test/test_*")
    s.add_dependency("nokogiri", "~> 1.13")
    s.require_paths = ["lib", "data"]
    s.rubygems_version = %q{1.6.2}
    s.license = "MIT"
    s.post_install_message = "Thanks for installing the SalesforceCertificationCalculator module!"
    s.summary="Calculates cumulative percentage from Salesforce certification section results"
    s.homepage="https://github.com/jtreeves/salesforce_certification_calculator"
end