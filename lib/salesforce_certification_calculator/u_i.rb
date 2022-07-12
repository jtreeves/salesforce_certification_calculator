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
end