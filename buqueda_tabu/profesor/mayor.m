function z = mayor(V2)

may=-1;
r=1;


for j=1:4
    x1=V2(j,1:10);
    valor=funx210(x1);
    if (may < valor)
        may=valor;
        r=j;
    end
end
z=r;


