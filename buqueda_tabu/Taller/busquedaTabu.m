% Cargar matrices
load("data.mat")
% Parámetros del algoritmo de búsqueda tabú
numero_iteraciones =input('Digite numero de iteraciones: ');
[numero_trabajadores,numero_trabajos] = size(C);
asignacionActual = randperm(numTrabajos, numTrabajos); % Genera una asignación aleatoria de trabajadores a trabajos
% Función para calcular el costo de una asignación
calcularCosto = @(asignacion) sum(sum(Cij .* (asignacion == 1:numTrabajos))) + sum(sum(rij .* (asignacion ~= 1:numTrabajos)));
% Inicialización de la mejor asignación encontrada
mejorAsignacion = asignacionActual;
mejorCosto = calcularCosto(mejorAsignacion);
% Inicialización de la lista tabú
listaTabu = zeros(tam_lista_tabu, numTrabajos);
% Bucle principal de la búsqueda tabú
for iteracion = 1:numero_iteraciones
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
