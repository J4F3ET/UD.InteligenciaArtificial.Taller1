function z = funx210(x)

suma=0;

for i=1:10
    suma = suma+x(i)*(2^(10-i));
end

z=suma*suma;
