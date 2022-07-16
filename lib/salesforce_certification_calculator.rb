class SalesforceCertificationCalculator
    # @!attribute [r] exam
    #   @return [Exam] object being used for calculations
    attr_reader :exam

    # Creates SalesforceCertificationCalculator object
    # 
    # @example Create Calculator Object
    #   >> calculator = SalesforceCertificationCalculator.new
    def initialize
        @exams = []
        @exam = Exam.new
        @reader = FileReader.new
        @ui = UI.new
    end

    # Gets list of all exams in the database, including their names and file paths; shortcut for FileReader method to modify exams attribute on object
    # 
    # @example Retrieve Exams
    #   >> calculator = SalesforceCertificationCalculator.new
    #   >> exams = calculator.generate_exams_list
    #   => [<SalesforceCertificationCalculator::Exam 0x000987>, <SalesforceCertificationCalculator::Exam 0x000988>]
    def generate_exams_list
        @exams = @reader.generate_exams_list
    end

    # Gets all details about an exam's sections, including names and weights; shortcut for FileReader method to modify exam attribute on object
    # 
    # @example Retrieve Exam Data
    #   >> calculator = SalesforceCertificationCalculator.new
    #   >> exams = calculator.generate_exams_list
    #   >> exam = calculator.extract_exam_data(exams[0])
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
    # 
    # @param exam [Exam] object, containing name and file properties, to use to get full data
    def extract_initial_exam_data
        @exam = @reader.extract_initial_exam_data(@exam)
    end

    # Determines cumulative score for the exam based on its sections' weights and scores; shortcut for Exam method that returns total value of exam after calculating total
    # 
    # @example Calculate Total
    #   >> calculator = SalesforceCertificationCalculator.new
    #   >> total = calculator.calculate_total
    #   => 87
    # 
    # @return [Number] cumulative score on exam
    def calculate_total
        @exam.calculate_total

        return @exam.total
    end

    # Determines cumulative score manually; shortcut that combines all of UI's methods
    # 
    # @example Calculate Total
    #   >> calculator = SalesforceCertificationCalculator.new
    #   >> total = calculator.determine_percentage_manually
    #   => 87
    # 
    # @return [Number] cumulative score on exam
    def determine_percentage_manually
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