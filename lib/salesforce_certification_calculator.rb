class SalesforceCertificationCalculator
    def initialize
        @exams = []
        @exam = Exam.new
        @accessor = Accessor.new
        @ui = UI.new
    end

    def determine_percentage
        choice = @ui.select_list_or_new

        if choice == "LIST"
            @exams = @accessor.get_exams_list
            @exam = @ui.select_specific_exam(@exams)
            @exam = @accessor.get_existing_exam_data(@exam)
            @exam = @ui.retrieve_scores(@exam)
        else
            @exam = @ui.create_temporary_exam
        end

        @exam.calculate_total

        return @exam.get_total
    end
end

require "salesforce_certification_calculator/exam"
require "salesforce_certification_calculator/u_i"
require "salesforce_certification_calculator/accessor"