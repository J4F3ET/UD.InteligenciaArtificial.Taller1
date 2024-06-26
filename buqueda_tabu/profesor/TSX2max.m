clear;
numero_iteraciones=input('Digite numero de iteraciones: ');
x_actual=1:10;

%Genera un x_actual random [0,1,0,0,0...]
for i=1:10
    x_actual(i)=randi(2)-1;
end
%funx210 eleva al cuadrado -> x_actual f=(x^2)
nivel_vector_aspiracion=funx210(x_actual);
mejor_solucion=x_actual;

%Inicializa la lista y la llena de 0
lista_tabu=1:3;%[0,0,0]
for i=1:3
    lista_tabu(i)=0;
end

%Itera de 1 a Numero de iteraciones
for i=1:numero_iteraciones

    %Itera de 1 a 4
    %Se encuentra de manera ALEATORIA la posicion a cambiar y la cambia
    for j=1:4
        % Almacena en la fila j de la matriz "vector_modificacion" a "x_actual"
        vector_modificacion(j,:)=x_actual;
        %Encuentra un numero random de 1 a 10
        k=randi(10);
        %Asigna 'k' a la posicion en j del vector(array) "movimiento"
        movimiento(j)=k;

        %Si "vector_modificacion" en su posicion "j"(fila) y "k"(columna)
        %es 0 entonces se cambia a 1 si no es 0 se cambia a 0 
        if (vector_modificacion(j,k)==0) 
            vector_modificacion(j,k)=1;
        else
            vector_modificacion(j,k)=0;
        end
        
    end
    %Devuelve la posicion del valor mayor dentro del vector_modificacion
    posicion_mejor=mayor(vector_modificacion);
    
    %Retorna 1 si el movimiento ya esta registrado en lista_tabu
    %y 0 si no esta registrado el movimiento
    movimiento_es_tabu=verificatabu(movimiento(posicion_mejor),lista_tabu);

    
    if (movimiento_es_tabu==0)%Si movimiento es tabu es 0(no esta registrado)
        
        %El "x_actual" cambia a la mejor modificacion registrada en "vector_modificacion"
        x_actual=vector_modificacion(posicion_mejor,:);

        
        %Se actualiza la lista tabu con el movimiento en primera posicion
        %siempre
        lista_tabu=actualizar_lista_tabu(movimiento(posicion_mejor),lista_tabu,movimiento_es_tabu);
        
        %Si el nivel de aspiracion(valor antes del algoritmo) es menor que
        %el valor dado actual (x_actual despues del algoritmo) se quiere
        %decir que se tuvo una mejora
        if (nivel_vector_aspiracion < funx210(x_actual))
            nivel_vector_aspiracion=funx210(x_actual);
            mejor_solucion=x_actual;
        end
    else% Si el movimiento es 1(esta registrado)
        candidato=vector_modificacion(posicion_mejor,1:10);
        % Si candidato es un buen movimiento entonces lo vuelve a
        % registrar
        if (funx210(candidato)> nivel_vector_aspiracion)
            x_actual=candidato;
            nivel_vector_aspiracion=funx210(x_actual);
            mejor_solucion=x_actual;
            lista_tabu=actualizar_lista_tabu(movimiento(posicion_mejor),lista_tabu,movimiento_es_tabu);
        end
    end
 lista_tabu;
   xgraf(i)=i;
   graf(i)=funx210(x_actual);
   grafasp(i)=nivel_vector_aspiracion;
        
end
disp(mejor_solucion);
plot (xgraf,graf,xgraf,grafasp);

