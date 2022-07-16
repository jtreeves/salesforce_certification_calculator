class SalesforceCertificationCalculator::FileReader
    SFC = SalesforceCertificationCalculator

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