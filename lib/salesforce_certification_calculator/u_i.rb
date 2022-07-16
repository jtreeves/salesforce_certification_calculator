class SalesforceCertificationCalculator::UI
    SFC = SalesforceCertificationCalculator

    def select_list_or_new
        puts "Do you want to select an exam from a list (enter LIST), or do you want to type in your own details (enter NEW)?" : "You must enter either LIST or NEW"
        choice = gets.chomp

        if choice == "LIST" || choice == "NEW"
            return choice
        else
            select_list_or_new()
        end
    end

    def select_specific_exam(exams)
        puts "Your choices are:"
        exams.each do |exam|
            puts "#{exams.find_index(exam) + 1} - #{exam.title}"
        end
        puts "Which one would you like to select? Enter the number before the exam name:"
        choice = gets.chomp.to_i

        if choice.between?(1, exams.length)
            return exams[choice - 1]
        else
            select_specific_exam(exams)
        end
    end

    def provide_scores(exam)
        sections = exam.sections

        sections.each do |section|
            puts "#{section.name} is worth #{section.weight}%"
            puts "What score did you get on that section? (enter an integer)"
            score = gets.chomp.to_i
            section.score = score
        end

        return exam
    end

    def provide_all_details_manually
        exam = SFC::Exam.new
        puts "What is the title of this exam?"
        exam.title = gets.chomp
        puts "How many sections does it have?"
        length = gets.chomp.to_i

        (1..length).each do |i|
            puts "What is the name of Section #{i}"
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