require "minitest/autorun"
require "nokogiri"
require "salesforce_certification_calculator"

class ExamTest < Minitest::Test
    Exam = SalesforceCertificationCalculator::Exam
    @@exam = Exam.new
    @@methods = @@exam.methods
    
    def test_initialize_title_exists
        assert_includes @@methods, :title, "should create an object with a title attribute"
    end
    
    def test_initialize_title_setter
        assert_includes @@methods, :title=, "should create an object with a method for setting the title attribute"
    end
    
    def test_initialize_title_string
        assert_instance_of String, @@exam.title, "should create an object with a title attribute of type string"
    end
    
    def test_initialize_file_exists
        assert_includes @@methods, :file, "should create an object with a file attribute"
    end
    
    def test_initialize_file_setter
        assert_includes @@methods, :file=, "should create an object with a method for setting the file attribute"
    end
    
    def test_initialize_file_string
        assert_instance_of String, @@exam.file, "should create an object with a file attribute of type string"
    end
    
    def test_initialize_sections_exists
        assert_includes @@methods, :sections, "should create an object with a sections attribute"
    end
    
    def test_initialize_sections_array
        assert_instance_of Array, @@exam.sections, "should create an object with a sections attribute of type array"
    end
    
    def test_initialize_total_exists
        assert_includes @@methods, :total, "should create an object with a total attribute"
    end
    
    def test_initialize_total_integer
        assert_instance_of Integer, @@exam.total, "should create an object with a total attribute of type integer"
    end
    
    def test_add_section_exists
        assert_includes @@methods, :add_section, "should create an object with a method called add_section"
    end
    
    def test_calculate_total_exists
        assert_includes @@methods, :calculate_total, "should create an object with a method called calculate_total"
    end
    
    def test_add_section_name_weight_increments
        initial_sections = @@exam.sections.length
        @@exam.add_section("Database", 24)
        updated_sections = @@exam.sections.length

        assert_equal initial_sections + 1, updated_sections, "should add a new section to exam object when invoke add_section method without score"
    end
    
    def test_add_section_name_weight_default_0_score
        @@exam.add_section("Database", 24)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal 0, recent_section.score, "should give new section a score of 0 if no score parameter supplied"
    end
    
    def test_add_section_name_weight_score_increments
        initial_sections = @@exam.sections.length
        @@exam.add_section("Database", 24, 80)
        updated_sections = @@exam.sections.length

        assert_equal initial_sections + 1, updated_sections, "should add a new section to exam object when invoke add_section method with score"
    end

    def test_add_section_name_weight_score_new_value
        score_value = 80
        @@exam.add_section("Database", 24, score_value)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal score_value, recent_section.score, "should give new section a score matching the score parameter if supplied"
    end

    def test_calculate_total_1_section
        exam = Exam.new
        exam.add_section("Database", 100, 65)
        exam.calculate_total

        assert_equal 65, exam.total, "should set total to first section's score if exam contains only 1 section with a weight of 100 after invoking calculate_total"
    end

    def test_calculate_total_2_sections
        exam = Exam.new
        exam.add_section("Database", 40, 65)
        exam.add_section("Application", 60, 85)
        exam.calculate_total

        assert_equal 77, exam.total, "should set total correctly when calculate_total called on exam containing 2 sections"
    end

    def test_calculate_total_3_sections
        exam = Exam.new
        exam.add_section("Database", 25, 62)
        exam.add_section("Application", 35, 83)
        exam.add_section("Program", 40, 54)
        exam.calculate_total

        assert_equal 66.15, exam.total, "should set total correctly when calculate_total called on exam containing 3 sections"
    end

    def test_calculate_total_many_sections
        exam = Exam.new
        exam.add_section("Section 1", 5, 82)
        exam.add_section("Section 2", 6, 93)
        exam.add_section("Section 3", 7, 54)
        exam.add_section("Section 4", 8, 62)
        exam.add_section("Section 5", 9, 80)
        exam.add_section("Section 6", 10, 40)
        exam.add_section("Section 7", 12, 50)
        exam.add_section("Section 8", 13, 60)
        exam.add_section("Section 9", 14, 70)
        exam.add_section("Section 10", 16, 65)
        exam.calculate_total

        assert_equal 63.62, exam.total, "should set total correctly when calculate_total called on exam containing multiple sections"
    end

    def test_calculate_total_administrator
        exam = Exam.new
        exam.file = "data/Administrator-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Administrator data"
    end

    def test_calculate_total_advanced_administrator
        exam = Exam.new
        exam.file = "data/AdvancedAdministrator-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Advanced Administrator data"
    end

    def test_calculate_total_b2b_solution_architect
        exam = Exam.new
        exam.file = "data/B2BSolutionArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with B2B Solution Architect data"
    end

    def test_calculate_total_b2c_solution_architect
        exam = Exam.new
        exam.file = "data/B2CSolutionArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with B2C Solution Architect data"
    end

    def test_calculate_total_data_architect
        exam = Exam.new
        exam.file = "data/DataArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Data Architect data"
    end

    def test_calculate_total_development_lifecycle_and_deployment_architect
        exam = Exam.new
        exam.file = "data/DevelopmentLifecycleAndDeploymentArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Development Lifecycle and Deployment Architect data"
    end

    def test_calculate_total_education_cloud_consultant
        exam = Exam.new
        exam.file = "data/EducationCloudConsultant-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Education Cloud Consultant data"
    end

    def test_calculate_total_experience_cloud_consultant
        exam = Exam.new
        exam.file = "data/ExperienceCloudConsultant-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Experience Cloud Consultant data"
    end

    def test_calculate_total_identity_and_access_management_architect
        exam = Exam.new
        exam.file = "data/IdentityAndAccessManagementArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Identity and Access Management Architect data"
    end

    def test_calculate_total_integration_architect
        exam = Exam.new
        exam.file = "data/IntegrationArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Integration Architect data"
    end

    def test_calculate_total_javascript_developer_i
        exam = Exam.new
        exam.file = "data/JavaScriptDeveloperI-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with JavaScript Developer I data"
    end

    def test_calculate_total_marketing_cloud_administrator
        exam = Exam.new
        exam.file = "data/MarketingCloudAdministrator-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Marketing Cloud Administrator data"
    end

    def test_calculate_total_marketing_cloud_consultant
        exam = Exam.new
        exam.file = "data/MarketingCloudConsultant-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Marketing Cloud Consultant data"
    end

    def test_calculate_total_marketing_cloud_developer
        exam = Exam.new
        exam.file = "data/MarketingCloudDeveloper-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Marketing Cloud Developer data"
    end

    def test_calculate_total_marketing_cloud_email_specialist
        exam = Exam.new
        exam.file = "data/MarketingCloudEmailSpecialist-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Marketing Cloud Email Specialist data"
    end

    def test_calculate_total_platform_app_builder
        exam = Exam.new
        exam.file = "data/PlatformAppBuilder-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Platform App Builder data"
    end

    def test_calculate_total_platform_developer_i
        exam = Exam.new
        exam.file = "data/PlatformDeveloperI-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Platform Developer I data"
    end

    def test_calculate_total_platform_developer_ii
        exam = Exam.new
        exam.file = "data/PlatformDeveloperII-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Platform Developer II data"
    end

    def test_calculate_total_sales_cloud_consultant
        exam = Exam.new
        exam.file = "data/SalesCloudConsultant-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Sales Cloud Consultant data"
    end

    def test_calculate_total_service_cloud_consultant
        exam = Exam.new
        exam.file = "data/ServiceCloudConsultant-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Service Cloud Consultant data"
    end

    def test_calculate_total_sharing_and_visibility_architect
        exam = Exam.new
        exam.file = "data/SharingAndVisibilityArchitect-Spring2022.xml"
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")
    
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i, 100)
        end

        exam.calculate_total
    
        assert_equal 100, exam.total, "should set total correctly when calculate_total called on exam with Sharing and Visibility Architect data"
    end

    def test_calculate_total_fails_low
        exam = Exam.new
        exam.add_section("Section 1", 10, 100)
        exam.add_section("Section 2", 15, 80)
        exam.add_section("Section 3", 20, 60)
        exam.calculate_total
    
        assert_equal "CANNOT CALCULATE", exam.total, "should set total to CANNOT CALCULATE when calculate_total called on exam with section weights that add up to less than 100"
    end

    def test_calculate_total_fails_high
        exam = Exam.new
        exam.add_section("Section 1", 20, 100)
        exam.add_section("Section 2", 30, 80)
        exam.add_section("Section 3", 40, 60)
        exam.add_section("Section 4", 50, 70)
        exam.calculate_total
    
        assert_equal "CANNOT CALCULATE", exam.total, "should set total to CANNOT CALCULATE when calculate_total called on exam with section weights that add up to more than 100"
    end

    def test_calculate_total_fails_no_sections
        exam = Exam.new
        exam.calculate_total
    
        assert_equal "CANNOT CALCULATE", exam.total, "should set total to CANNOT CALCULATE when calculate_total called on exam with no sections"
    end
end