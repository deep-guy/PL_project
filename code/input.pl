% This module contains code for reading data from a csv and 
% creating appropriate matrices from it, that can be sent to computation.

:- module(input, [read_file/3]).

% Using inbuilt library for reading CSV files
:- use_module(library(csv), [csv_read_file/3]).
:- use_module(library(clpfd), [transpose/2]).

% Function to append one list to the end of another
append([], Result, Result).
append([H | T], B, [H | Y]) :- append(T, B, Y).

% Creating the final list of Y values
create_y_list(Yin, Yout) :-
    transpose([Yin], Yout).

% Creating the final list of X values
create_x_list(Len, Len, Lst, Out, Final) :-
    L = [Lst],
    Temp = [Out|L],
    transpose(Temp, Final).

create_x_list(Len1, Len2, Lst, Out, Final) :-
    succ(Len2, X),
    create_x_list(Len1, X, Lst, [1|Out], Final).

create_list([], Lst_x, Lst_y, New_x, Lst_y) :- 
    length(Lst_x, X),
    create_x_list(X, 0, Lst_x, [], New_x).

% Creating lists in required format from output of csv function
create_list([row(X, Y)|T], Lst_x, Lst_y, Xlist, Ylist) :-
    append(Lst_x, [X], Lst2_x),
    append(Lst_y, [Y], Lst2_y),
    create_list(T, Lst2_x, Lst2_y, Xlist, Ylist).

read_file(Fname, Xlist, Ylist) :-
    csv_read_file(Fname, Rows, [strip(true), convert(true), arity(2)]),
    create_list(Rows, [], [], Xlist, Y1),
    create_y_list(Y1, Ylist).
    

