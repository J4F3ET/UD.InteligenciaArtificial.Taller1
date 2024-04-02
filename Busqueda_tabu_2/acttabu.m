function z = acttabu(movmej,listabu2,estabu2)

if (estabu2==0)
    for i=3:-1:2
       listabu2(i)=listabu2(i-1);
    end
    listabu2(1)=movmej;
else
    pos=1;
    while (pos <= 3) && (listabu2(pos)~=movmej)
        pos=pos+1;
    end
    if (pos~=1)
        for i=pos:-1:2
            listabu2(i)=listabu2(i-1);
        end
        listabu2(1)=movmej;
    end
end     
z=listabu2;
end