clear;
n=input('Digite numero de iteraciones: ')
xactual=1:10;


for i=1:10
    xactual(i)=randi(2)-1;
end

nivasp=funx210(xactual);
mejorsol=xactual;

listabu=1:3;

for i=1:3
    listabu(i)=0;
end


for i=1:n
    for j=1:4
        V(j,1:10)=xactual; 
        k=randi(10);
        
        mov(j)=k;
        
        if (V(j,k)==0) 
            V(j,k)=1;
        else
            V(j,k)=0;
        end
        
    end
    
    mejor=mayor(V);
    
    estabu=verificatabu(mov(mejor),listabu);
    
    if (estabu==0)
        
        xactual=V(mejor,1:10);
        
        
        listabu=acttabu(mov(mejor),listabu,estabu);
        
        if (nivasp < funx210(xactual))
            nivasp=funx210(xactual);
            mejorsol=xactual;
        end
    else
        cand=V(mejor,1:10);
        
        if (funx210(cand)> nivasp)
            xactual=cand;
            nivasp=funx210(xactual);
            mejorsol=xactual;
            listabu=acttabu(mov(mejor),listabu,estabu);
            
        end
    end
 listabu
   xgraf(i)=i;
   graf(i)=funx210(xactual);
   grafasp(i)=nivasp;
        
end

mejorsol
plot (xgraf,graf,xgraf,grafasp);

