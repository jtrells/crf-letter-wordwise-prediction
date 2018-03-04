function probs = calculateYjYj_1GivenX2(F, B, logZ, T, w, x, wj, wj_1, j, wordLength, alphabet_size)
    
    probs = 0;
    if j > 1 && j < wordLength - 1
        for k = 1 : alphabet_size
            for h = 1 : alphabet_size
                probs = probs + exp(F(h, j-1) + T(h, wj) + B(k, j+2) + T(wj_1, k) + w(:,wj)'* x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ);
            end
        end
    elseif j == 1
        for k = 1 : alphabet_size
            probs = probs + exp(B(k, j+2) + T(wj_1, k) + w(:,wj)'*x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ);
        end
    else
        for h = 1 : alphabet_size
            probs = probs + exp(F(h, j-1) + T(h, wj) + w(:,wj)'*x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ);
        end
    end
end
