

C=[17 21 22 18 24 15 20 18 19 18 16 22 24 24 16;
 23 16 21 16 17 16 19 25 18 21 17 15 25 17 24;
 16 20 16 25 24 16 17 19 19 18 20 16 17 21 24;
 19 19 22 22 20 16 19 17 21 19 25 23 25 25 25;
 18 19 15 15 21 25 16 16 23 15 22 17 19 22 24;];

r=[8 15 14 23 8 16 8 25 9 17 25 15 10 8 24;
 15 7 23 22 11 11 12 10 17 16 7 16 10 18 22;
 21 20 6 22 24 10 24 9 21 14 11 14 11 19 16;
 20 11 8 14 9 5 6 19 19 7 6 6 13 9 18;
 8 13 13 13 10 20 25 16 16 17 10 10 5 12 23;];

b=[36; 
    34; 
    38; 
    27; 
    33;];

% Inicialización
X = zeros(5, 15); % Genera una matriz X de ceros de tamaño 5x15
for j = 1:15
    fila = randi([1 5]);
    X(fila, j) = 1; % Para cada columna de X, selecciona aleatoriamente una fila y coloca un 1 en esa posición
end



n = input('Digite número de iteraciones: ');
nivasp_vector = zeros(1, n); %Vector para guardar los niveles de aspiracion
nivasp = funcobj(C, X, r, b);
mejorsol = X;

listabu = 1:3;
for i = 1:3
    listabu(i) = 0;
end

for i = 1:n
    X_nuevo = X;
    columna = randi([1 15]);
    fila_actual = find(X(:, columna) == 1);
    fila_nueva = fila_actual;
    while fila_nueva == fila_actual
        fila_nueva = randi([1 5]);
    end
    X_nuevo(fila_actual, columna) = 0;
    X_nuevo(fila_nueva, columna) = 1;
    V = X_nuevo;
    mejor = mayor(V, C, r, b);
    estabu = verificatabu(mejor, listabu);
    if (estabu == 0) || (funcobj(C, V, r, b) > nivasp)
        X = V;
        nivasp = funcobj(C, X, r, b);
        nivasp_vector(i) = nivasp; % Almacenar el nivel de aspiración
        mejorsol = X;
        if length(listabu) < 3
            listabu(end+1) = mejor;
        else
            listabu(1) = mejor;
        end
    end
    fprintf('Iteración %d:\n', i);
    disp('xactual:');
    disp(X);
    disp('V:');
    disp(V);
end
disp('=========================================FIN================================================================')
disp('La mejor solución es:');
disp(X);
disp('El nivel de aspiración para la mejor solución es:');
disp(nivasp);
disp('La matriz de soluciones vecinas es:');
disp(V);
final = funcobj(C, X, r, b);
disp('El valor final de la función objetivo para la mejor solución es:');
disp(final);
plot(1:n, nivasp_vector); % Dibuja el gráfico
xlabel('Iteración'); % Etiqueta el eje x
ylabel('Nivel de aspiración');





