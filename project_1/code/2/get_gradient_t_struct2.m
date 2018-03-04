% this is more likely wrong but keeping it for the record
function [tGrads] = get_gradient_t_struct2(word_list, w, T)
    alphabet_size = 26;

    num_words = size(word_list,2);
    tGrads = zeros(alphabet_size, alphabet_size);

    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, logz] = get_forward_memo_mat_struct2(x, w, T);
        [B, junk] = get_backwards_memo_mat_struct2(x, w, T);
        wordLength = length(y);
        
        expF = exp(F);
        expB = exp(B);
        Z = exp(logz);
        
        % trying to minimize number of transformations by remapping the
        % vectors out from the loops
        featureF = repmat(expF, [alphabet_size,1]);
        featureB = get_cached_feature_B(expB, alphabet_size);


        % pre compute the dot products, and avoid repetitions
        dotW_Xs = sum(bsxfun(@times, w, x(:,1)));

        for s = 1 : wordLength - 1
            
            if s == 1 || s == wordLength - 1
                msgF = expF(:,s);
                msgB = expB(:,s+1);
            else
                msgF = featureF(:,s);   % 0 when s = 1
                msgB = featureB(:,s+1); % 0 when s = wordLength - 1
            end
            
            prodMsgs = bsxfun(@times, msgF, msgB);
            dotW_Xs1 = sum(bsxfun(@times, w, x(:,s+1)));
            
            for i = 1 : alphabet_size
                for j = 1 : alphabet_size
                    msgTi_iplus1 = T(i,j);
                    %msgXs = w(:,i)'*x(:,s) + w(:,j)'*x(:,s+1);
                    msgXs = dotW_Xs(i) + dotW_Xs1(j);
                    
                    %scalarSum = exp(msgTi_iplus1 + msgXs - logz);
                    scalarSum = exp(msgTi_iplus1 + msgXs);
                    %p = msgF + msgB + scalarSum; 
                    %p = sum(exp(p));
                    p = prodMsgs .* scalarSum;
                    p = p ./ Z;
                    p = sum(p);
                    
                    indicator = (y(s) == i && y(s+1) == j);
                    tGrads(i, j) = tGrads(i, j) + indicator - p;
                end
            end
            dotW_Xs = dotW_Xs1;    
        end
        
    end

end

function featB = get_cached_feature_B(B, alphabet_size)
% vectorize B to get entries with the order
% [a a a ... b b b ... z z z]' for the first if condition
% as the featF gives me [a b c d ... a b c d ..]. Thus, I can get
% all the possible combinations

    featB = [];
    for i = 1 : size(B,2)
        sel = B(:,i)';
        sel = repmat(sel, [alphabet_size,1]);
        featB = [featB reshape(sel, alphabet_size ^ 2, 1)];
    end
end

function featT2 = get_cached_featured_T2(T, alphabet_size)
% similar to matrix B used in the backwards path. Moreover, the matrix is
% transposed here to avoid transpose operations in the loop. Therefore, the
% call for T(wj_1,:)' in the first if is now T(:,wj_1)
    featT2 = [];
    for i = 1 : alphabet_size
        sel = T(i,:);
        sel = repmat(sel, [alphabet_size,1]);
        featT2 = [featT2 reshape(sel, alphabet_size ^ 2, 1)];
    end
end

