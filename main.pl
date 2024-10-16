% Declaración de operadores para permitir notación infija
:- op(200, xfy, ^).     % Exponenciación
:- op(400, yfx, *).     % Multiplicación
:- op(400, yfx, /).     % División
:- op(500, yfx, +).     % Suma
:- op(500, yfx, -).     % Resta
:- op(600, fy, sen).    % Función seno
:- op(600, fy, cos).    % Función coseno
:- op(600, fy, tan).    % Función tangente
:- op(600, fy, arctan). % Función arcotangente
:- op(600, fy, exp).    % Función exponencial
:- op(600, fy, ln).     % Función logaritmo natural

% Regla base: La derivada de una constante es cero
derivada(N, _, 0) :- number(N).

% Regla base: La derivada de una variable respecto a sí misma es uno
derivada(X, X, 1).

% La derivada de una variable diferente es cero
derivada(Y, _, 0) :- atom(Y), Y \= _.

% Regla de la suma: La derivada de una suma es la suma de las derivadas
derivada(U + V, X, DU + DV) :-
    derivada(U, X, DU),
    derivada(V, X, DV).

% Regla de la resta: La derivada de una resta es la resta de las derivadas
derivada(U - V, X, DU - DV) :-
    derivada(U, X, DU),
    derivada(V, X, DV).

% Regla del producto: La derivada de un producto U*V es U*DV + DU*V
derivada(U * V, X, U * DV + DU * V) :-
    derivada(U, X, DU),
    derivada(V, X, DV).

% Regla del cociente: La derivada de un cociente U/V es (DU*V - U*DV)/(V^2)
derivada(U / V, X, (DU * V - U * DV) / (V ^ 2)) :-
    derivada(U, X, DU),
    derivada(V, X, DV).

% Regla de la potencia con exponente constante: d/dx(U^N) = N*U^(N-1)*DU
derivada(U ^ N, X, N * U ^ N1 * DU) :-
    number(N),
    N1 is N - 1,
    derivada(U, X, DU).

% Regla de la potencia con exponente variable: d/dx(U^V) = U^V * (DV * ln(U) + V * DU / U)
derivada(U ^ V, X, U ^ V * (DV * ln(U) + V * DU / U)) :-
    \+ number(V),
    derivada(U, X, DU),
    derivada(V, X, DV).

% Regla de la cadena para la función logaritmo natural: d/dx(ln(U)) = DU / U
derivada(ln(U), X, DU / U) :-
    derivada(U, X, DU).

% Regla de la cadena para la función exponencial: d/dx(exp(U)) = exp(U) * DU
derivada(exp(U), X, exp(U) * DU) :-
    derivada(U, X, DU).

% Regla de la cadena para la función seno: d/dx(sen(U)) = cos(U) * DU
derivada(sen(U), X, cos(U) * DU) :-
    derivada(U, X, DU).

% Regla de la cadena para la función coseno: d/dx(cos(U)) = -sen(U) * DU
derivada(cos(U), X, -sen(U) * DU) :-
    derivada(U, X, DU).

% Regla de la cadena para la función tangente: d/dx(tan(U)) = (1 + tan(U)^2) * DU
derivada(tan(U), X, (1 + tan(U) ^ 2) * DU) :-
    derivada(U, X, DU).

% Regla de la cadena para la función arcotangente: d/dx(arctan(U)) = DU / (1 + U^2)
derivada(arctan(U), X, DU / (1 + U ^ 2)) :-
    derivada(U, X, DU).

% Meta para ejecutar los ejemplos
run_examples :-
    derivada(ln(x/(x+1)), x, Y1),
    write('Ejemplo 1:'), nl, write('Y = '), write(Y1), nl, nl,

    derivada(sen(exp(3*x)), x, Y2),
    write('Ejemplo 2:'), nl, write('Y = '), write(Y2), nl, nl,

    derivada(ln(sen((x+1)/x)), x, Y3),
    write('Ejemplo 3:'), nl, write('Y = '), write(Y3), nl, nl,

    derivada((x^5 + x^3)/(x^2 + 1), x, Y4),
    write('Ejemplo 4:'), nl, write('Y = '), write(Y4), nl, nl,

    derivada(arctan((x^2 + 1)^10), x, Y5),
    write('Ejemplo 5:'), nl, write('Y = '), write(Y5), nl, nl.
