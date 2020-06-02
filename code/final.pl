% row(M, N, Row) :-
%     nth1(N, M, Row).

% column(M, N, Col) :-
%     transpose(M, MT),
%     row(MT, N, Col).

% symmetrical(M) :-
%     transpose(M, M).

% Transpose of a list whose first element is an empty list halts.

% transpose([[]|_], []) :- !. 
% transpose([[I|Is]|Rs], [Col|MT]) :-
%     first_column([[I|Is]|Rs], Col, [Is|NRs]),
%     transpose([Is|NRs], MT).

% first_column([], [], []).
% first_column([[]|_], [], []).
% first_column([[I|Is]|Rs], [I|Col], [Is|Rest]) :- first_column(Rs, Col, Rest).

:- use_module(library(clpfd), [transpose/2]).

% :- use_module(matrix, [matrix_inversion/2]).

matrix([[a,b,c],[d,e,f],[g,h,i]]).

matrix_multiply(X,Y,M) :-
    matrix_mul(X,Y,M0),
    maplist(maplist(is), M, M0).

matrix_mul(X, Y, M) :-
    transpose(Y, T),
    maplist(row_multiply(T), X, M).

row_multiply(T, X, M) :-
    maplist(dot_product(X), T, M).

% foldl folds a list from left to right according to the function provided as first argument. It uses corresp. elements
% of both lists if 2 are provided, and the corresponding function must be appropriate.
% Write about meta-predicates. Very Important.

% foldl-:
% foldl(predicade, list, intermediate_state, final_ans)
% where:-
% predicate(list_element, initial_state, final_state).

dot_product([X|Xs], [T|Ts], M) :-
    foldl(mul, Xs, Ts, X*T, M).

mul(X, T, M, M+X*T).

invert([[A,B],[C,D]], [[IA,IB],[IC,ID]]) :-                    
    Det is A*D-B*C,
    Det \= 0,
    IDet is 1/Det,
    IA is IDet*D, IB is IDet*(-B),
    IC is IDet*(-C), ID is IDet*A.


get_ans_matrix(X, Y, Ans) :- 
    transpose(X, X_t),
    matrix_multiply(X_t, X, P_1),
    matrix_multiply(X_t, Y, P_2),
    invert(P_1, Inv),
    matrix_multiply(Inv, P_2, Ans).
