%matriz_v2 debe ser una matriz con valores a comparar
function z = mayor(matriz_v2)
    valor_mayor=-1;
    r=1;
     
    for j=1:4
        %retorna todos los valores de la fila j y los asigna a "x"
        x=matriz_v2(j,:);
        %retorna el valor(numero decimal)  correspondiente a "x" ("x" es [0,1,0,0...])
        valor=funx210(x);
        if(valor_mayor < valor)
            valor_mayor=valor;
            r=j;
        end
    end
    z=r;
end

