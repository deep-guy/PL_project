append([], Result, Result).
append([H | T], B, [H | Y]) :- append(T, B, Y).

loop_input(1, []) :- 
    write('Enter all values of x (every value in newline). End entering values with x'), nl,
    read(X),
    loop_input(X, []).

loop_input([], Lst) :- 
    write('The entered list is :'), nl,
    write(Lst).

loop_input(X, Lst) :-
    append(Lst, [X], Lst2),
    read(Y),
    loop_input(Y, Lst2).


