function probs = calc_probYjYj_1_X2(featureF, B, featureB, logZ, dotWX, TW, T, featureT1, w, x, wj, wj_1, j, wordLength, alphabet_size)
    
    scals = dotWX + TW - logZ;
    
    if j > 1 && j < wordLength - 1
        % exp(F(h, j-1) + T(h, wj) + B(k, j+2) + T(wj_1, k) + w(:,wj)'* x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ)
        featF  =  featureF(:,j-1);
        featT1 =  featureT1(:, wj);
        featB = featureB(:,j+2);
        
        sel_T2 = T(wj_1,:);
        sel_T2 = repmat(sel_T2, [alphabet_size, 1]);
        featT2 = reshape(sel_T2, alphabet_size ^ 2, 1);
               
        f = featF + featT1 + featB + featT2 + scals;
        probs = sum(exp(f));
    elseif j == 1
        % exp(B(k, j+2) + T(wj_1, k) + w(:,wj)'*x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ)
        %featB = featureB(1:26,j+2);
        featB = B(:,j+2);
        featT = T(wj_1,:)';
        %featT = featureT2(wj_1,:)';
        
        f = featB + featT + scals;
        probs = sum(exp(f));
    else
        % exp(F(h, j-1) + T(h, wj) + w(:,wj)'*x(:,j) + w(:,wj_1)'*x(:,j + 1) + T(wj, wj_1) - logZ)
        featF = featureF(1:26,j-1);
        featT = featureT1(1:26,wj);
        
        f = featF + featT + scals;
        probs = sum(exp(f));
    end
end
