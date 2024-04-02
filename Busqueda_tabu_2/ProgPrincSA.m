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

X = zeros(5, 15); % Genera una matriz X de ceros de tamaño 5x15

for j = 1:15
    fila = randi([1 5]);
    X(fila, j) = 1; % Para cada columna de X, selecciona aleatoriamente una fila y coloca un 1 en esa posición
end

b=[36; 
    34; 
    38; 
    27; 
    33;];

tic; % Inicia el cronómetro
% Parámetros del algoritmo
n1 = 200; % Número de iteraciones con diferente temperatura
n2 = 100; % Número de iteraciones con igual temperatura
T = 1000; % Temperatura inicial
T_min = 0.01; % Temperatura mínima
alfa = 0.9; % Factor de enfriamiento
% Valor de la función objetivo para la solución inicial
z = funcobj(C, X, r, b);
iteraciones = 0; % Inicializa el contador de iteraciones
zetas = []; % Arreglo para almacenar los resultados y posterior graficacion



while T > T_min
    for i = 1:n1
        % Genera una nueva solución vecina
        X_nuevo = X; % Copia la matriz actual X
        columna = randi([1 15]); % Selecciona aleatoriamente una columna
        fila_actual = find(X(:, columna) == 1); % Encuentra la posición del 1 en la columna seleccionada
        fila_nueva = fila_actual;
        while fila_nueva == fila_actual
            fila_nueva = randi([1 5]);
        end
        X_nuevo(fila_actual, columna) = 0; %donde estaba el 1 se coloca el 0
        X_nuevo(fila_nueva, columna) = 1 %se repocisiona el 1

        for j = 1:n2
            % Calcula el valor de la función objetivo para la nueva solución
            z_nuevo = funcobj(C, X_nuevo, r, b);
            
            % Decide si acepta la nueva solución o no
            if z_nuevo > z || rand < exp((z_nuevo - z) / T)
                X = X_nuevo;
                z = z_nuevo;
                % Imprime X_nuevo y z_nuevo solo si z_nuevo es mayor que z
                disp(X_nuevo);
                fprintf('z_nuevo = %d\n', z_nuevo);
                zetas = [zetas,z];
            end
            iteraciones = iteraciones + 1; % Incrementa el contador de iteraciones
        end
    end
    
    % Reduce la temperatura
    T = alfa * T;
end

% La solución óptima
X_optimo = X;
z_optimo = z;
X_optimo
z_optimo

final = funcobj(C, X_optimo, r, b);

iteraciones
toc; % Detiene el cronómetro y muestra el tiempo transcurrido
plot(zetas);
xlabel("Iteracion");
ylabel("Valor de z por iteracion"); 



%{
while T > T_min
    % Realiza n1 ciclos de búsqueda
    for i = 1:n1
        % Realiza n2 búsquedas en cada ciclo
        for j = 1:n2
            % Genera una nueva solución vecina
            X_nuevo = X; % Crea una copia de la solución actual
            columna = randi([1 15]); % Selecciona aleatoriamente una columna
            fila_actual = find(X(:, columna) == 1); % Encuentra la posición del 1 en la columna seleccionada
            
            % Genera una nueva posición aleatoria para el 1 en la misma columna
            fila_nueva = fila_actual;
            while fila_nueva == fila_actual
                fila_nueva = randi([1 5]); % Asegurarce que la nueva posición no sea la misma que la posición actual
            end
            
            % Mueve el 1 a la nueva posición
            X_nuevo(fila_actual, columna) = 0; % Coloca un 0 en la posición actual del 1
            X_nuevo(fila_nueva, columna) = 1; % Coloca un 1 en la nueva posición
            
            % Calcula el valor de la función objetivo para la nueva solución
            z_nuevo = funcobj(C, X_nuevo, r, b);
            
            % Decide si acepta la nueva solución o no
            if z_nuevo > z || rand < exp((z_nuevo - z) / T)
                X = X_nuevo; % Actualiza la solución actual con la nueva solución
                z = z_nuevo; % Actualiza el valor de la función objetivo
                % Imprime la nueva solución y su valor de la función objetivo
                disp(X_nuevo);
                fprintf('z_nuevo = %d\n', z_nuevo);
                zetas = [zetas,z];
            end
            % Incrementa el contador de iteraciones
            iteraciones = iteraciones + 1;
        end
    end
    % Reduce la temperatura
    T = alfa * T;
end
%}



