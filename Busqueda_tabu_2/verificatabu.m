function z = verificatabu(movmej, listabu2)
    for i = 1:length(listabu2)
        if movmej == listabu2(i)
            z = 1;
            return;
        end
    end
    z = 0;
end