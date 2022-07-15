class SalesforceCertificationCalculator
    attr_reader :exam

    def initialize
        @exams = []
        @exam = Exam.new
        @reader = FileReader.new
        @ui = UI.new
    end

    def get_exams_list
        @exams = @reader.get_exams_list
    end

    def get_existing_exam_data
        @exam = @reader.get_existing_exam_data(@exam)
    end

    def calculate_total
        @exam.calculate_total

        return @exam.total
    end

    def determine_percentage
        choice = @ui.select_list_or_new

        if choice == "LIST"
            @exams = @reader.get_exams_list
            @exam = @ui.select_specific_exam(@exams)
            @exam = @reader.get_existing_exam_data(@exam)
            @exam = @ui.retrieve_scores(@exam)
        else
            @exam = @ui.create_temporary_exam
        end

        @exam.calculate_total

        return @exam.total
    end
end

require "salesforce_certification_calculator/exam"
require "salesforce_certification_calculator/u_i"
require "salesforce_certification_calculator/file_reader"