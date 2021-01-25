# Prolog and AI: A Study

This is a repository containing work done for a study on prolog, and it's potential applications into AI. For more info, check PL_report.pdf

## Code: Bivariate least squares linear regressor using matrix multiplication

### Usage:-

* load all files (main.pl, calculate.pl, input.pl) into the same directory
* load 'main.pl' into swipl terminal (?- [main].)
* run main function (?- main.)
* every input must be followed by a period (.)
* filename must be input as: 'filename.extension'.

### To prepare 2 columns from dataset (Boston house pricing) :-

* run format.py
* select required column indices
* the data will be saved in 'test_data.csv'


### Code Structure:-

* ‘input.pl’: Contains code for reading x and y values from a csv file and formatting them as appropriate X and Y matrices.
* ‘calculate.pl’: Contains code for matrix operations such as addition, subtraction, multiplication, and performs these operations on input to generate Hypothesis Parameters and Sum of Squared Errors.
* ‘main.pl’: Interfaces with the user.
