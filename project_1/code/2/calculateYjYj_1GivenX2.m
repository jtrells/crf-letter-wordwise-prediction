function probs = calculateYjYj_1GivenX(F, B, logZ, T, w, x, wj, wj_1, j, wordLength)
    
    probs = 0;
    if j > 1 && j < wordLength - 1
        for k = 1 : 26
            for h = 1 : 26
                probs = probs + exp(F(h, j-1) + T(h, wj) + B(k, j+2) + T(wj_1, k) + dot(w(:,wj), x(:,j)) + dot(w(:,wj_1), x(:,j + 1)) + T(wj, wj_1) - logZ);
            end
        end
    elseif j == 1
        for k = 1 : 26
            probs = probs + exp(B(k, j+2) + T(wj_1, k) + dot(w(:,wj), x(:,j)) + dot(w(:,wj_1), x(:,j + 1)) + T(wj, wj_1) - logZ);
        end
    else
        for h = 1 : 26
            probs = probs + exp(F(h, j-1) + T(h, wj) + dot(w(:,wj), x(:,j)) + dot(w(:,wj_1), x(:,j + 1)) + T(wj, wj_1) - logZ);
        end
    end
end
