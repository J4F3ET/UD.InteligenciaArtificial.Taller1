function z = mayor(V, C, r, b)
    n = size(V, 1);
    valores = zeros(1, n);
    for i = 1:n
        valores(i) = funcobj(C, V(i, :), r, b);
    end
    [~, indice] = max(valores);
    z = indice;
end