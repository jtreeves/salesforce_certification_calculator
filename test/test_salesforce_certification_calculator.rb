require "minitest/autorun"
require "salesforce_certification_calculator"

class SalesforceTest < Minitest::Test
    SFC = SalesforceCertificationCalculator

    def test_cumulative_score
        calculator = SFC.new([20, 80], [70, 60])
        score = calculator.cumulative_score

        assert_equal score, 62
    end
end