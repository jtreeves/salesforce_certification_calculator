class SalesforceCertificationCalculator
    # @!attribute exam
    #   @return [Exam] object being used for calculations
    # 
    # @!attribute [r] exams
    #   @return [Array] collection of Exam objects used for temporary storage
    attr_accessor :exam
    attr_reader :exams

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
    #   >> calculator.generate_exams_list
    #   >> calculator.exam = calculator.exams[1]
    #   >> calculator.extract_exam_data
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
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
    # @return [Number] cumulative score on exam; if sections' weights do not sum to 100, it will return an error message as a string
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

            puts "You selected: #{@exam.title}"
            puts "Enter your scores for each of the exam's #{@exam.sections.length} sections in the order you are prompted"
            
            @exam = @ui.provide_scores(@exam)
        else
            @exam = @ui.provide_all_details_manually
        end

        @exam.calculate_total

        puts "Your cumulative score is: #{@exam.total}%"

        return @exam.total
    end
end

require "salesforce_certification_calculator/exam"
require "salesforce_certification_calculator/u_i"
require "salesforce_certification_calculator/file_reader"