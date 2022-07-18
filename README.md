# Salesforce Certification Calculator

*Calculates cumulative percentage from Salesforce certification section results*

**Contents**
1. [Description](https://github.com/jtreeves/salesforce_certification_calculator#description)
2. [Inspiration](https://github.com/jtreeves/salesforce_certification_calculator#inspiration)
3. [Requirements](https://github.com/jtreeves/salesforce_certification_calculator#requirements)
4. [Installation](https://github.com/jtreeves/salesforce_certification_calculator#installation)
5. [Features](https://github.com/jtreeves/salesforce_certification_calculator#features)
6. [Usage](https://github.com/jtreeves/salesforce_certification_calculator#usage)
7. [Code Examples](https://github.com/jtreeves/salesforce_certification_calculator#code-examples)
8. [Testing](https://github.com/jtreeves/salesforce_certification_calculator#testing)
9. [Future Goals](https://github.com/jtreeves/salesforce_certification_calculator#future-goals)

## Description

A **Ruby** gem module for taking all the sections' weights and scores provided by **Salesforce** and using them to generate a cumulative score for the entire exam.

## Inspiration

I've taken a few Salesforce certification exams in my day, and I was always annoyed that even though Salesforce provides you with your score on a given section, it refuses to provide you with a simple cumulative score. It does tell you if you passed of failed, but it would be useful to know by exactly how much. I created this module to give users a simple way to achieve that for themselves.

## Requirements

- Ruby (check with `ruby -v`)
- Nokogiri (check with `nokogiri -v`), which may be automatically installed when you install the main module

## Installation

### Download Package

```
gem install salesforce_certification_calculator
```

### Create Local Repository

If you have trouble downloading the package or just want to play around with the code yourself, you can clone down the repository. Ensure you already have Ruby on your local computer. (You can check this by executing `ruby -v`.)

1. Fork this repository
2. Clone it to your local computer
3. From within your local version of the directory, build the module: `gem build salesforce_certification_calculator.gemspec`
4. Then install that built module: `gem install ./salesforce_certification_calculator-0.1.0.gem`
5. Open a Ruby environment to use the module: `irb`
6. Execute any of the recently installed methods

You may need to update the specific version of the build as later releases come out (e.g., `-0.1.0.gem` may need to become `-0.2.0.gem`).

## Features

## Usage

## Code Examples

**Final function to generate the cumulative score from all provided section data**
```ruby
def calculate_total
    summed_weights = 0

    @sections.each do |section|
        summed_weights += section.weight
        @total += section.weight * section.score / 100.0
    end

    if summed_weights != 100
        @total = "CANNOT CALCULATE"
    end
end
```

**Helper function to pull data stored in a reference XML file**
```ruby
def extract_initial_exam_data(exam)
        doc = File.open(exam.file) { |f| Nokogiri::XML(f) }
    names = doc.xpath("//name")
    weights = doc.xpath("//weight")

    (0..names.length-1).each do |i|
        exam.add_section(names[i].content, weights[i].content.to_i)
    end

    return exam
end
```

## Testing

This project has 103 automated tests, located in the `test` folder at the root. To run them, execute `rake test`. In order to successfully run these tests, you may need to also install `stringio` and `o_stream_catcher`.

## Future Goals

- Extract score data from text file (or better yet, a PDF or directly from an email message), and use that to also determine which exam it is for in the hopes of minimizing the amount of data that the user needs to key in
- More robust error handling and exception raising for when a user attempts to run `calculate_total` on an exam with sections whose weights do not equal 100; similar issue with interacting with the UI methods