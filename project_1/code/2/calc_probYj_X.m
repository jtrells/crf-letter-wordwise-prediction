function [probs] = calc_probYj_X(featureF, B, vlogZ, wDotX, T, featureT1, j, yj, wordLength, alphabet_size)

    %F, B, vlogZ, wDotX, T, j, yj, wordLength, alphabet_size

    % there are some differences, check the else conditions
    if j > 1 && j < wordLength
        %probs = probs + exp(F(h, j-1) + T(h, yj) + B(k, j+1) + T(yj, k) + wDotX - logZ);
        %feature_F = repmat(F(:, j-1), [alphabet_size, 1]);
        feature_F =  featureF(:,j-1);
        %feature_T1 = repmat(T(:,yj), [alphabet_size, 1]);
        feature_T1 = featureT1(:, yj);
        
        sel_B = B(:,j+1)';
        sel_B = repmat(sel_B, [alphabet_size, 1]);
        feature_B = reshape(sel_B, alphabet_size ^ 2, 1);
        %feature_B = featureB(:,j+1)';
        
        sel_T2 = T(yj,:);
        sel_T2 = repmat(sel_T2, [alphabet_size, 1]);
        feature_T2 = reshape(sel_T2, alphabet_size ^ 2, 1);
        %feature_T2 = featureT2(yj,:)';
        
        
        feature_dot = repmat(wDotX, [alphabet_size ^ 2, 1]);
        feature_logZ = vlogZ;
        
        f = feature_F + feature_T1 + feature_B + feature_T2 + feature_dot - feature_logZ;
        f = exp(f);
        probs = sum(f);
    elseif j == 1
        % probs = probs + exp(B(k, j+1) + T(yj, k) + wDotX - logZ);        
        feature_B = B(:,j+1);
        feature_T = T(yj,:)';
        feature_dot = repmat(wDotX,  [alphabet_size, 1]);
        
        f = feature_B + feature_T + feature_dot - vlogZ(1:26);
        probs = sum(exp(f));
    else
        % probs = probs + exp(F(h, j-1) + T(h, yj) + wDotX - logZ);
        
        feature_F = featureF(1:26,j-1);
        feature_T = featureT1(1:26,yj);
        feature_dot = repmat(wDotX,  [alphabet_size, 1]);
        
        f = feature_F + feature_T + feature_dot - vlogZ(1:26);
        probs = sum(exp(f));
    end
end

