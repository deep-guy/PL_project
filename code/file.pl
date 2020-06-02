:- use_module(library(csv)).

append([], Result, Result).
append([H | T], B, [H | Y]) :- append(T, B, Y).

get_input(Fname, Xlist, Ylist) :-
    read_file(Fname, Xlist, Ylist).

create_x_list(Len, Len, Lst, Out, Final) :-
    Final = [[Out]|[Lst]].

create_x_list(Len1, Len2, Lst, Out, Final) :-
    succ(Len2, X),
    create_x_list(Len1, X, Lst, [1|Out], Final).

create_list([], Lst_x, Lst_y, New_x, Lst_y) :- 
    length(Lst_x, X),
    create_x_list(X, 0, Lst_x, [], New_x).

create_list([row(X, Y)|T], Lst_x, Lst_y, Xlist, Ylist) :-
    append(Lst_x, [X], Lst2_x),
    append(Lst_y, [Y], Lst2_y),
    create_list(T, Lst2_x, Lst2_y, Xlist, Ylist).

read_file(Fname, Xlist, Ylist) :-
    csv_read_file(Fname, Rows, [strip(true), convert(true), arity(2)]),
    create_list(Rows, [], [], Xlist, Ylist).
    

