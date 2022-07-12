class SalesforceCertificationCalculator::UI
    def select_existing_exam(times = 0)
        message = times == 0 ? "Do you want to select an existing exam? (enter Y or N)" : "You must enter either Y or N"
        puts message
        input = gets.chomp
        selected_existing

        if input == "Y"
            selected_existing = true
        elsif input == "N"
            select_existing_exam = false
        else
            select_existing_exam(1)
        end

        return selected_existing
    end

    def select_specific_exam(exams)
        puts "Your choices are:"
        exams.each do |exam|
            puts "#{exams.find_index(exam) + 1} - #{exam.get_title}"
        end
        puts "Which one would you like to select? Enter the number before the exam name:"
        input = gets.chomp
        index

        if input.between?(1, exams.length)
            index = input - 1
        else
            select_specific_exam(exams)
        end

        return index
    end
end