function z = verificatabu(valor_movimiento_mejor,lista_tabu)
    z=0;
    for i=1:3
        if valor_movimiento_mejor==lista_tabu(i)
            z=1;
        end
    end
end