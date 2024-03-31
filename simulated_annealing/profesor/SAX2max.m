clear;
T=input('Digite la temperatura inicial: ');
n1=input('Digite el numero de iteraciones con diferente temperatura: ');
n2=input('Digite el numero de iteraciones con igual temperatura: ');

xactual=1:10;

for i=1:10
    xactual(i)=randi(2)-1;
end

for i=1:n1
    for j=1:n2
        xnuevo=xactual;
        
        k=randi(10);
        
        if (xnuevo(k)==0) xnuevo(k)=1;
        else xnuevo(k)=0;
        end
        
        delta = funx210(xnuevo)-funx210(xactual);
        
        if (delta > 0)
            xactual=xnuevo;
        else
            aleat=rand;
            if (aleat < exp(delta/T))
                xactual=xnuevo;
            end
        end
    end
            
       T=0.97*T;
     
       graf(i)=funx210(xactual);
end
xactual
funx210(xactual)     
plot (graf);

