# Salesforce Certification Calculator

*Calculates cumulative percentage from Salesforce certification section results*

**Contents**
1. [Description](#description)
2. [Inspiration](#inspiration)
3. [Features](#features)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Documentation](#documentation)
8. [Code Examples](#code-examples)
9. [Testing](#testing)
10. [Future Goals](#future-goals)

## Description

A **Ruby** gem module for taking all the sections' weights and scores provided by **Salesforce** and using them to generate a cumulative score for the entire exam. Built using [Ruby's guide to making gems](https://guides.rubygems.org/make-your-own-gem/). View the details on the [published module on Ruby's site](https://rubygems.org/gems/salesforce_certification_calculator).

## Inspiration

I've taken a few Salesforce certification exams in my day, and I was always annoyed that even though Salesforce provides you with your score on a given section, it refuses to provide you with a simple cumulative score. It does tell you if you passed of failed, but it would be useful to know by exactly how much. Previously, I would use a calculator to manually enter the data. However, given how many sections an exam may have, I can mis-enter some data. I created this module to give users a simple way to achieve that for themselves.

## Features

- Archive of files with key details for 21 current exams, including their sections and weights
- File reading functionality
- User interface for the CLI to provide prompts to walk user through the input process
- Methods for calculating the cumulative total and for walking the user through all stages of data collection
- Executable to allow user to run the module's core functionality with a simple command in the CLI instead of needing to go into a Ruby shell

## Requirements

- Ruby (check with `ruby -v`)
- Nokogiri (check with `nokogiri -v`), which may be automatically installed when you install the main module

## Installation

### Set Up Environment

1. Install `rbenv` via Homebrew: `brew install rbenv`
2. Add the code block below these steps to your `.zshrc` config file
3. Install latest version of Ruby via the `rbenv` package: `rbenv install 3.1.2`
4. Set global version of Ruby via the `rbenv` package: `rbenv global 3.1.2`
5. Fix `racc` version: `gem pristine racc --version 1.6.0`

```bash
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.1.0/bin:$PATH"
eval "$(rbenv init - zsh)"
export PATH=$HOME/.rbenv/shims:$PATH
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
```

### Download Package

```
gem install salesforce_certification_calculator
```

### Create Local Repository

If you have trouble downloading the package or just want to play around with the code yourself, you can clone down the [repository on GitHub](https://github.com/jtreeves/salesforce_certification_calculator). Ensure you already have Ruby on your local computer. (You can check this by executing `ruby -v`.)

1. Fork this repository
2. Clone it to your local computer
3. From within your local version of the directory, build the module: `gem build salesforce_certification_calculator.gemspec`
4. Then install that built module: `gem install ./salesforce_certification_calculator-0.2.6.gem`
5. Open a Ruby environment to use the module: `irb`
6. Execute any of the recently installed methods

You may need to update the specific version of the build as later releases come out (e.g., `-0.2.6.gem` may need to become `-0.3.0.gem`).

## Usage

### Module

1. Open a Ruby environment to use the module: `irb`
2. Require the package: `require 'salesforce_certification_calculator'`
3. Create a new calculator to use: `calculator = SalesforceCertificationCalculator.new`
4. Use the main method to provide data and generate your cumulative score: `calculator.determine_percentage_manually`
5. Fill in the data in response to the questions as they're presented, and the final output will be your cumulative score

Of course, you may use any of the other methods provided by the package, but `determine_percentage_manually` is the core method.

### Executable

This package also contains an executable, so you can run its core functionality (the above `determine_percentage_manually` method) directly from the CLI without needing to enter a Ruby shell:

```
salesforce_certification_calculator
```

## Documentation

This project uses **YARD** for documentation generation. To view the published form, see the [documentation on the RubyDoc site](https://www.rubydoc.info/gems/salesforce_certification_calculator/). To view the docs locally, go to the `doc` folder. To generate the docs yourself, execute `rake yard` in the CLI from the root of your local copy of the project.

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
    else
        @total = @total.round(2)
    end
end
```

**Helper function to pull data stored in a reference XML file**
```ruby
def extract_initial_exam_data(exam)
    file_path = @base_path + "/" + exam.file
    doc = File.open(file_path) { |f| Nokogiri::XML(f) }
    names = doc.xpath("//name")
    weights = doc.xpath("//weight")

    (0..names.length-1).each do |i|
        exam.add_section(names[i].content, weights[i].content.to_i)
    end

    return exam
end
```

## Testing

This project has 107 automated tests, located in the `test` folder at the root. To run them, execute `rake test`. In order to successfully run these tests, you may need to also install `stringio` and `o_stream_catcher`.

## Future Goals

- Extract score data from text file (or better yet, a PDF or directly from an email message), and use that to also determine which exam it is for in the hopes of minimizing the amount of data that the user needs to key in
- More robust error handling and exception raising for when a user attempts to run `calculate_total` on an exam with sections whose weights do not equal 100; similar issue with interacting with the UI methods
- A **Rails** app to live in the browser and facilitate much of the above
- More aesthetically appealing documentation pages