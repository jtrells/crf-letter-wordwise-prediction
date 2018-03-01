potential = [ 0.1; 0.5 ];
T = [ 0.2 0.8; 0.6 0.4];

F = zeros(2, 3);
F(:,1) = potential;
for i = 2 : 3
    for s = 1 : 2
        for e = 1 : 2
            F(e,i) = F(e,i) + F(e,i-1) * T(s, e) * potential(e);
        end
    end
end