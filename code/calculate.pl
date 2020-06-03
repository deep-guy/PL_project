% This module contains code for taking the data in matrix form and applying the normal
% method for finding the slope and intercept of the linear regression line.

:- module(calculate, [find_regression_line/4]).
:- use_module(library(clpfd), [transpose/2]).  % Importing the transpose function from a prebuilt library

% Matrix addition: M3 is M1 + M2
matrix_add(M1, M2, M3) :- maplist(maplist(sum), M1, M2, M3).
sum(X,Y,Z) :- Z is X+Y.

% Matrix subtraction: M3 is M1 - M2
matrix_sub(M1, M2, M3) :- maplist(maplist(sub), M1, M2, M3).
sub(X, Y, Z) :- Z is X-Y.


% Code for matrix multiplication. Taken from https://stackoverflow.com/questions/34206275/matrix-multiplication-with-prolog
% M is X * Y
matrix_multiply(X, Y, M) :-
    matrix_mul(X, Y, M0),
    maplist(maplist(is), M, M0).

matrix_mul(X, Y, M) :-
    transpose(Y, T),
    maplist(row_multiply(T), X, M).

row_multiply(T, X, M) :-
    maplist(dot_product(X), T, M).

dot_product([X|Xs], [T|Ts], M) :-
    foldl(mul, Xs, Ts, X*T, M).

mul(X, T, M, M+X*T).

% Inverting a 2x2 matrix:-
invert([[A,B],[C,D]], [[IA,IB],[IC,ID]]) :-                    
    Det is A*D-B*C,
    Det \= 0,
    IDet is 1/Det,
    IA is IDet*D,
    IB is IDet*(-B),
    IC is IDet*(-C), 
    ID is IDet*A.

% Finding Error matrix, and calculating Sum Squared Error
find_error(X, Y, Ans, Err) :-
    matrix_multiply(X, Ans, M),
    matrix_sub(Y, M, E),
    transpose(E, E_t),
    matrix_multiply(E_t, E, Err).


% Finding [[intercept], [slope]] using the formula:-
% A = (X`X)^(-1) * (X`Y)
% Where X` : X transpose
find_regression_line(X, Y, Ans, Err) :- 
    transpose(X, X_t),
    matrix_multiply(X_t, X, P_1),
    matrix_multiply(X_t, Y, P_2),
    invert(P_1, Inv),
    matrix_multiply(Inv, P_2, Ans),
    find_error(X, Y, Ans, Err).
