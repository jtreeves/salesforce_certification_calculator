class SalesforceCertificationCalculator::UI
    SFC = SalesforceCertificationCalculator

    # Allows user to select between viewing a list of all existing exams or inputting all data manually
    # 
    # @example Make Choice
    #   >> ui = UI.new
    #   >> choice = ui.select_list_or_new
    #   => 'LIST'
    # 
    # @return [String] 'LIST' to indicate user wants to see a list of all existing exams; 'NEW' to indicate user wants to input all data manually
    def select_list_or_new
        puts "Do you want to select an exam from a list (enter LIST), or do you want to type in your own details (enter NEW)?"
        choice = gets.chomp

        # Only return value if user selected one of the two provided options; otherwise, recursively recall function
        if choice == "LIST" || choice == "NEW"
            return choice
        else
            select_list_or_new()
        end
    end

    # Allows user to select which exam from the list of existing exams to use
    # 
    # @example Select a Specific Exam
    #   >> ui = UI.new
    #   >> reader = FileReader.new
    #   >> exams = reader.generate_exams_list
    #   >> exam = ui.select_specific_exam(exams)
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
    # 
    # @param exams [Array] collection of Exam objects to use for selection
    # 
    # @return [Exam] object with name, file, and section details for selected exam
    def select_specific_exam(exams)
        exams_length = exams.length

        puts "Your choices are:"

        # List exam options
        exams.each do |exam|
            puts "#{exams.find_index(exam) + 1} - #{exam.title}"
        end

        # Add option to take user back to the LIST or NEW prompt
        puts "#{exams_length + 1} - NOT LISTED"
        puts "Which one would you like to select? Enter the number before the exam name:"
        choice = gets.chomp.to_i

        if choice.between?(1, exams_length)
            # Only return value if user inputted number within range
            return exams[choice - 1]
        elsif choice == exams_length + 1
            # Allow user to opt out if last option entered
            select_list_or_new()
        else
            # Recursively recall function if invalid input
            select_specific_exam(exams)
        end
    end

    # Allows user to input their scores for each section
    # 
    # @example Enter Scores
    #   >> ui = UI.new
    #   >> reader = FileReader.new
    #   >> exams = reader.generate_exams_list
    #   >> exam = ui.select_specific_exam(exams)
    #   >> updated_exam = ui.provide_scores(exam)
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
    # 
    # @param exam [Exam] object with name, file, and section details
    # 
    # @return [Exam] object with name, file, and section details, updated with the individual scores for each section
    def provide_scores(exam)
        sections = exam.sections

        # Get scores for each section from the user
        sections.each do |section|
            puts "#{section.name} is worth #{section.weight}%"
            puts "What score did you get on that section? (enter an integer)"
            score = gets.chomp.to_i
            section.score = score
        end

        return exam
    end

    # Allows user to provide all exam data manually
    # 
    # @example Input Information
    #   >> ui = UI.new
    #   >> exam = ui.provide_all_details_manually
    #   => <SalesforceCertificationCalculator::Exam 0x000987>
    # 
    # @return [Exam] object with name, file, and section details, including scores for each section
    def provide_all_details_manually
        exam = SFC::Exam.new
        puts "What is the title of this exam?"
        exam.title = gets.chomp
        puts "How many sections does it have?"
        length = gets.chomp.to_i

        # Get names, weights, and scores for each section of the exam from the user
        (1..length).each do |i|
            puts "What is the name of Section #{i}?"
            name = gets.chomp
            puts "How many percentage points is Section #{i} worth?"
            weight = gets.chomp.to_i
            puts "What score did you get on Section #{i}?"
            score = gets.chomp.to_i
            exam.add_section(name, weight, score)
        end

        return exam
    end
end

require "salesforce_certification_calculator/exam"