class SalesforceCertificationCalculator
    def initialize(sections, scores)
        @sections = Vector.new(sections)
        @scores = Vector.new(scores)
    end

    def self.get_exams_list
        exams = []
        files = Dir.glob("data/*xml")

        files.each do |file|
            exam = Exam.new
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
            exam.add_section(names[i].content, weights[i].content)
        end

        return exam
    end

    def cumulative_score
        sections_percent = @sections.scalar_multiplication(0.01)
        scores_percent = @scores.scalar_multiplication(0.01)
        sections_percent_vector = Vector.new(sections_percent)
        scores_percent_vector = Vector.new(scores_percent)
        product = sections_percent_vector.dot_product(scores_percent_vector)
        total_score = product * 100
        
        return total_score
    end
end

require "nokogiri"
require "salesforce_certification_calculator/vector"
require "salesforce_certification_calculator/exam"