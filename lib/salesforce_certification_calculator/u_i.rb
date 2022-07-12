class SalesforceCertificationCalculator::UI
    def self.select_list_or_new(times = 0)
        message = times == 0 ? "Do you want to select an exam from a list (enter LIST), or do you want to type in your own details (enter NEW)?" : "You must enter either LIST or NEW"
        puts message
        choice = gets.chomp

        if choice == "LIST" || choice == "NEW"
            return choice
        else
            select_list_or_new(1)
        end
    end

    def self.select_specific_exam(exams)
        puts "Your choices are:"
        exams.each do |exam|
            puts "#{exams.find_index(exam) + 1} - #{exam.get_title}"
        end
        puts "Which one would you like to select? Enter the number before the exam name:"
        choice = gets.chomp.to_i

        if choice.between?(1, exams.length)
            return exams[choice - 1]
        else
            select_specific_exam(exams)
        end
    end

    def self.retrieve_scores(exam)
        sections = exam.get_sections
        
        sections.each do |section|
            puts "#{section.get_name} is worth #{section.get_weight}%"
            puts "What score did you get on that section? (enter an integer)"
            score = gets.chomp.to_i
            section.set_score(score)
        end

        return exam
    end
end