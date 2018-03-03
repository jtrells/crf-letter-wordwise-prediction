function probs = calculateYjGivenX(F, B, logZ, wDotX, T, j, yj, wordLength)
%     probs = zeros(26,26);

    probs = 0;
    if j > 1 && j < wordLength
        for k = 1 : 26
            for h = 1 : 26
                probs = probs + exp(F(h, j-1) + T(h, yj) + B(k, j+1) + T(yj, k) + wDotX - logZ);
            end
        end
    elseif j == 1
        for k = 1 : 26
            probs = probs + exp(B(k, j+1) + T(yj, k) + wDotX - logZ);
        end
    else
        for h = 1 : 26
            probs = probs + exp(F(h, j-1) + T(h, yj) + wDotX - logZ);
        end
    end
end

