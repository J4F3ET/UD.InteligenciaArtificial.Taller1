% Cargar matrices
clear;
load("data.mat")
numero_iteraciones=input('Digite numero de iteraciones: ');
[numero_Trabajadores, numero_Trabajos] = size(C);
%Genera un x_actual random
x_actual=randi([0, 1], numero_Trabajadores, numero_Trabajos);
x_actual(1,:)
%funcion_objetivo
nivel_vector_aspiracion=funcion_objetivo(C,x_actual,r,b);
mejor_solucion=x_actual;
%Inicializa la lista y la llena de 0
lista_tabu=zeros(numero_Trabajadores,numero_Trabajos,3);
for i=1:3
    lista_tabu(i)=0;
end

%Itera de 1 a Numero de iteraciones
for i=1:numero_iteraciones
    %Itera de 1 a 4
    %Se encuentra de manera ALEATORIA la posicion a cambiar y la cambia
    %Vecindario es un conjunto de soluciones en este caso una matriz 5x15
    vecindario = zeros(numero_Trabajadores,numero_Trabajos,numero_Trabajadores);
    for j=1:numero_Trabajadores%Filas 5
        m=randi(numero_Trabajadores);
        n=randi(numero_Trabajos);
        vecindario(:,:,j) = x_actual;
        if(vecindario(m,n,j)==0)
            vecindario(m,n,j)=1;
        else
            vecindario(m,n,j)=0;
        end
    end
    %Devuelve la posicion del valor mayor dentro del vecindario
    [mejor_vecino_indice,mejor_vecino_costo]=mayor(vecindario,numero_Trabajadores,C,r,b);
    candidato = vecindario(:,:,mejor_vecino_indice);
    % Actualiza la asignación actual y la lista tabú
    es_tabu=verifica_es_tabu(candidato,lista_tabu);
    if(es_tabu==0)
        x_actual=candidato;
    end
    if(funcion_objetivo(C,candidato,r,b)>nivel_vector_aspiracion)
        nivel_vector_aspiracion = funcion_objetivo(C,candidato,r,b);
        mejor_solucion=candidato;
        lista_tabu=actualizar_lista_tabu(candidato,lista_tabu,es_tabu);
    end
    xgraf(i)=i;
    graf(i)=(funcion_objetivo(C,x_actual,r,b));
    grafasp(i)=nivel_vector_aspiracion; 
end
disp(nivel_vector_aspiracion);
plot (xgraf,graf,xgraf,grafasp);