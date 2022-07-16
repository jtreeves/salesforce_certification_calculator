class SalesforceCertificationCalculator::FileReader
    SFC = SalesforceCertificationCalculator

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
        files = Dir.glob("data/*xml")

        files.each do |file|
            exam = SFC::Exam.new
            doc = File.open(file) { |f| Nokogiri::XML(f) }
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
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
        names = doc.xpath("//name")
        weights = doc.xpath("//weight")

        (0..names.length-1).each do |i|
            exam.add_section(names[i].content, weights[i].content.to_i)
        end

        return exam
    end
end

require "nokogiri"
require "salesforce_certification_calculator/exam"