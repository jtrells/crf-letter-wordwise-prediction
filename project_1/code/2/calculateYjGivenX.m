function probs = calculateYjGivenX(F, B, logZ, wDotX, T, j, yj, wordLength, alphabet_size)
%     probs = zeros(26,26);

    probs = 0;
    if j > 1 && j < wordLength
        for k = 1 : alphabet_size
            for h = 1 : alphabet_size
                probs = probs + exp(F(h, j-1) + T(h, yj) + B(k, j+1) + T(yj, k) + wDotX - logZ);
            end
        end
    elseif j == 1
        for k = 1 : alphabet_size
            probs = probs + exp(B(k, j+1) + T(yj, k) + wDotX - logZ);
        end
    else
        for h = 1 : alphabet_size
            probs = probs + exp(F(h, j-1) + T(h, yj) + wDotX - logZ);
        end
    end
end

