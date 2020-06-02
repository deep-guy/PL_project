% This code contains the 'main' function, and interfaces with the user.

:- use_module(calculate, [find_regression_line/3]).
:- use_module(input, [read_file/3]).

% Calculate y, given x, slope and intercept
calculate_y(X, [[Intercept], [Slope]], Y) :-
    Y is (X*Slope)+Intercept.

% Infinite loop for repeated queries.
value_calc([], _).
value_calc(Check, Param) :-
    Check \= [],
    write('Enter some x value for which you want to calculate y (number followed by .)'), nl,
    read(X),
    calculate_y(X, Param, Y),
    write('The corresponding Y is: '),
    write(Y), nl,
    write('Enter any number to continue. Enter []. to halt'), nl,
    read(Next),
    value_calc(Next, Param).

% main "function"
main :-
    write('Enter the name of the data file (eg: \'data.csv\').'), nl,
    read(Fname),
    read_file(Fname, Xlist, Ylist),
    write('File read successfully'), nl,
    find_regression_line(Xlist, Ylist, Param),
    write('Hypothesis parameters successfully calculated.'), nl,
    value_calc(0, Param).
