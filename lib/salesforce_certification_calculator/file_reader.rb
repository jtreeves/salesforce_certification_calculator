class SalesforceCertificationCalculator::FileReader
    SFC = SalesforceCertificationCalculator

    # Creates FileReader object by establishing a base path
    # 
    # @example Create FileReader Object
    #   >> fr = FileReader.new
    def initialize
        sfc_gems = []

        # Get full path to where Ruby gems are stored on user's computer, starting at the base
        gems_path = ENV["HOME"] + "/gems/gems"
        all_gems = Dir.children(gems_path)

        # Create list of all versions of module installed on user's computer
        all_gems.each do |gem|
            if gem.include? "salesforce_certification_calculator"
                sfc_gems.push(gem)
            end
        end

        # Determine most recent version of module available
        sfc_gems.sort
        latest_sfc = sfc_gems[sfc_gems.length - 1]

        # Set path variable for use by the class's methods
        @base_path = gems_path + "/" + latest_sfc
    end

    # Gets list of all exams in the database, including their names and file paths
    # 
    # @example Retrieve Exams
    #   >> reader = FileReader.new
    #   >> exams = reader.generate_exams_list
    #   => [<SalesforceCertificationCalculator::Exam 0x000987>, <SalesforceCertificationCalculator::Exam 0x000988>]
    # 
    # @return [Array] collection of Exam objects
    def generate_exams_list
        exams = []
        files = Dir.glob("data/*xml", base: @base_path)

        # Create list of all exams, including their titles and file paths
        files.each do |file|
            exam = SFC::Exam.new
            file_path = @base_path + "/" + file
            doc = File.open(file_path) { |f| Nokogiri::XML(f) }
            title = doc.at_xpath("//title")
            exam.title = title.content
            exam.file = file
            exams.push(exam)
        end

        return exams
    end

    # Gets all details about an exam's sections, including names and weights
    # 
    # @example Retrieve Exam Data
    #   >> reader = FileReader.new
    #   >> exams = FileReader.generate_exams_list
    #   >> exam = reader.extract_exam_data(exams[0])
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
    # 
    # @param exam [Exam] object, containing name and file properties, to use to get full data
    # 
    # @return [Exam] object with not only name and file, but also all sections, with their names and weights
    def extract_initial_exam_data(exam)
        file_path = @base_path + "/" + exam.file
        doc = File.open(file_path) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")

        # Add all sections' names and weights to existing exam data
        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i)
        end

        return exam
    end
end

require "nokogiri"
require "salesforce_certification_calculator/exam"