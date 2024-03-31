% Matrices de valores iniciales
Cij = [
[17, 21, 22, 18, 24, 15, 20, 18, 19, 18, 16, 22, 24, 24, 16];
[23, 16, 21, 16, 17, 16, 19, 25, 18, 21, 17, 15, 25, 17, 24];
[16, 20, 16, 25, 24, 16, 17, 19, 19, 18, 20, 16, 17, 21, 24];
[19, 19, 22, 22, 20, 16, 19, 17, 21, 19, 25, 23, 25, 25, 25];
[18, 19, 15, 15, 21, 25, 16, 16, 23, 15, 22, 17, 19, 22, 24]
];
rij = [
[8, 15, 14, 23, 8, 16, 8, 25, 9, 17, 25, 15, 10, 8, 24];
[15, 7, 23, 22, 11, 11, 12, 10, 17, 16, 7, 16, 10, 18, 22];
[21, 20, 6, 22, 24, 10, 24, 9, 21, 14, 11, 14, 11, 19, 16];
[20, 11, 8, 14, 9, 5, 6, 19, 19, 7, 6, 6, 13, 9, 18];
[8, 13, 13, 13, 10, 20, 25, 16, 16, 17, 10, 10, 5, 12, 23]
];
% Limite de asignación de trabajos para cada trabajador
bi = [36, 34, 38, 27, 33];
% Parámetros del algoritmo de búsqueda tabú
numIteraciones = 1000; % Número de iteraciones
tamListaTabu = 10; % Tamaño de la lista tabú
% Inicialización aleatoria de la asignación
[numTrabajadores, numTrabajos] = size(Cij);
asignacionActual = randperm(numTrabajos, numTrabajos); % Genera una asignación aleatoria de trabajadores a trabajos
% Función para calcular el costo de una asignación
calcularCosto = @(asignacion) sum(sum(Cij .* (asignacion == 1:numTrabajos))) + sum(sum(rij .* (asignacion ~= 1:numTrabajos)));
% Inicialización de la mejor asignación encontrada
mejorAsignacion = asignacionActual;
mejorCosto = calcularCosto(mejorAsignacion);
% Inicialización de la lista tabú
listaTabu = zeros(tamListaTabu, numTrabajos);
% Bucle principal de la búsqueda tabú
for iteracion = 1:numIteraciones
% Generar vecindario
vecindario = zeros(numTrabajadores, numTrabajos);
vecindarioCostos = zeros(1, numTrabajadores);
% Explora vecinos intercambiando trabajadores asignados a trabajos
for i = 1:numTrabajadores
for j = 1:numTrabajos
if asignacionActual(i) ~= j
vecindario(i, :) = asignacionActual;
vecindario(i, i) = j;
vecindarioCostos(i) = calcularCosto(vecindario(i, :));
end
end
end
% Encuentra el mejor vecino que no está en la lista tabú
mejorVecinoCosto = Inf;
mejorVecinoIndice = 0;
for i = 1:numTrabajadores
if vecindarioCostos(i) < mejorVecinoCosto && ~any(all(vecindario(i, :) == listaTabu, 2))
mejorVecinoCosto = vecindarioCostos(i);
mejorVecinoIndice = i;
end
end
% Actualiza la asignación actual y la lista tabú
asignacionActual = vecindario(mejorVecinoIndice, :);
listaTabu = circshift(listaTabu, [1, 0]);
listaTabu(1, :) = asignacionActual;
% Actualiza la mejor asignación si es necesario
if mejorVecinoCosto < mejorCosto
mejorAsignacion = asignacionActual;
mejorCosto = mejorVecinoCosto;
end
end
% Muestra la mejor asignación y su costo
disp('Mejor asignación encontrada:');
disp(mejorAsignacion);
disp(['Costo: ', num2str(mejorCosto)]);
% Muestra a qué trabajo fue asignado cada trabajador
for i = 1:numTrabajadores
disp(['Trabajador ', num2str(i), ' asignado al trabajo ', num2str(mejorAsignacion(i))]);
end
% Crea un gráfico de barras para mostrar la asignación
figure;
bar(mejorAsignacion);
xlabel('Trabajadores');
ylabel('Trabajos asignados');
title('Asignación de Trabajadores a Trabajos');
