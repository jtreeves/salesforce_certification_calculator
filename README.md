# Salesforce Certification Calculator

*Calculates cumulative percentage from Salesforce certification section results*

**Contents**
1. [Description](https://github.com/jtreeves/salesforce_certification_calculator#description)
2. [Inspiration](https://github.com/jtreeves/salesforce_certification_calculator#inspiration)
3. [Installation](https://github.com/jtreeves/salesforce_certification_calculator#installation)
4. [Features](https://github.com/jtreeves/salesforce_certification_calculator#features)
5. [Usage](https://github.com/jtreeves/salesforce_certification_calculator#usage)
6. [Code Examples](https://github.com/jtreeves/salesforce_certification_calculator#code-examples)
7. [Testing](https://github.com/jtreeves/salesforce_certification_calculator#testing)
8. [Future Goals](https://github.com/jtreeves/salesforce_certification_calculator#future-goals)

## Description

## Inspiration

## Installation

## Features

## Usage

## Code Examples

## Testing

This project has 101 automated tests, located in the `test` folder at the root. To run them, execute `rake test`.

## Future Goals

- Extract score data from text file (or better yet, a PDF or directly from an email message), and use that to also determine which exam it is for in the hopes of minimizing the amount of data that the user needs to key in
- More robust error handling and exception raising for when a user attempts to run `calculate_total` on an exam with sections whose weights do not equal 100; similar issue with interacting with the UI methods