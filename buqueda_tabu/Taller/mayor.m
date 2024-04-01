function [mejor_vecino_indice,valor_mayor] = mayor(vecindario,numero_trabajadores,C,r,b)
    valor_mayor = -1;
    mejor_vecino_indice=1;
    for i=1:numero_trabajadores
        valor = funcion_objetivo(C,vecindario(:,:,i),r,b);
        if(valor>valor_mayor)
            valor_mayor = valor;
            mejor_vecino_indice = i;
        end
    end
end

