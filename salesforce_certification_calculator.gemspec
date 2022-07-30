Gem::Specification.new do |s|
    s.name = "salesforce_certification_calculator"
    s.version = "0.2.6"
    s.executables << "salesforce_certification_calculator"
    s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["Jackson Reeves"]
    s.date = %q{2022-07-29}
    s.description = "Calculates cumulative percentage from Salesforce certification section results"
    s.email = %q{jr@jacksonreeves.com}
    s.files = [
        "README.md",
        "Rakefile",
        "bin/salesforce_certification_calculator",
        "lib/salesforce_certification_calculator.rb", 
        "lib/salesforce_certification_calculator/exam.rb", 
        "lib/salesforce_certification_calculator/section.rb",
        "lib/salesforce_certification_calculator/file_reader.rb",
        "lib/salesforce_certification_calculator/u_i.rb",
        "data/Administrator-Spring2022.xml",
        "data/AdvancedAdministrator-Spring2022.xml",
        "data/B2BSolutionArchitect-Spring2022.xml",
        "data/B2CSolutionArchitect-Spring2022.xml",
        "data/DataArchitect-Spring2022.xml",
        "data/DevelopmentLifecycleAndDeploymentArchitect-Spring2022.xml",
        "data/EducationCloudConsultant-Spring2022.xml",
        "data/ExperienceCloudConsultant-Spring2022.xml",
        "data/IdentityAndAccessManagementArchitect-Spring2022.xml",
        "data/IntegrationArchitect-Spring2022.xml",
        "data/JavaScriptDeveloperI-Spring2022.xml",
        "data/MarketingCloudAdministrator-Spring2022.xml",
        "data/MarketingCloudConsultant-Spring2022.xml",
        "data/MarketingCloudDeveloper-Spring2022.xml",
        "data/MarketingCloudEmailSpecialist-Spring2022.xml",
        "data/PlatformAppBuilder-Spring2022.xml",
        "data/PlatformDeveloperI-Spring2022.xml",
        "data/PlatformDeveloperII-Spring2022.xml",
        "data/SalesCloudConsultant-Spring2022.xml",
        "data/ServiceCloudConsultant-Spring2022.xml",
        "data/SharingAndVisibilityArchitect-Spring2022.xml"
    ]
    s.test_files = [
        "test/test_salesforce_certification_calculator.rb", 
        "test/test_exam.rb", 
        "test/test_section.rb",
        "test/test_file_reader.rb",
        "test/test_u_i.rb"
    ]
    s.add_runtime_dependency("nokogiri", "~> 1.13")
    s.add_development_dependency("rake", "~> 13.0")
    s.add_development_dependency("yard", "~> 0.9")
    s.add_development_dependency("stringio", "~> 3.0")
    s.add_development_dependency("o_stream_catcher", "~> 0.0.1")
    s.require_paths = ["lib", "data"]
    s.required_ruby_version = "~> 3.1"
    s.rubygems_version = %q{1.6.2}
    s.license = "MIT"
    s.post_install_message = "Thanks for installing the SalesforceCertificationCalculator module!"
    s.summary="Uses linear algebra to determine total scores on exams"
    s.homepage="https://github.com/jtreeves/salesforce_certification_calculator"
end