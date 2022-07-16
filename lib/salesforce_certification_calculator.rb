class SalesforceCertificationCalculator
    attr_reader :exam

    def initialize
        @exams = []
        @exam = Exam.new
        @reader = FileReader.new
        @ui = UI.new
    end

    def generate_exams_list
        @exams = @reader.generate_exams_list
    end

    def extract_initial_exam_data
        @exam = @reader.extract_initial_exam_data(@exam)
    end

    def calculate_total
        @exam.calculate_total

        return @exam.total
    end

    def determine_percentage
        choice = @ui.select_list_or_new

        if choice == "LIST"
            @exams = @reader.generate_exams_list
            @exam = @ui.select_specific_exam(@exams)
            @exam = @reader.extract_initial_exam_data(@exam)
            @exam = @ui.provide_scores(@exam)
        else
            @exam = @ui.provide_all_details_manually
        end

        @exam.calculate_total

        return @exam.total
    end
end

require "salesforce_certification_calculator/exam"
require "salesforce_certification_calculator/u_i"
require "salesforce_certification_calculator/file_reader"