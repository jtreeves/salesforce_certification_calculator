class SalesforceCertificationCalculator::Accessor
    SFC = SalesforceCertificationCalculator

    def get_exams_list
        exams = []
        files = Dir.glob("data/*xml")

        files.each do |file|
            exam = SFC::Exam.new
            doc = File.open(file) { |f| Nokogiri::XML(f) }
            title = doc.at_xpath("//title")
            exam.set_title(title.content)
            exam.set_file(file)
            exams.push(exam)
        end

        return exams
    end

    def get_existing_exam_data(exam)
        doc = File.open(exam.get_file) { |f| Nokogiri::XML(f) }
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