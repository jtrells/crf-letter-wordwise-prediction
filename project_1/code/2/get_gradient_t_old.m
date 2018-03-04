function [ tGrads ] = get_gradient_t_old( word_list, w, T )
%GET_GRADIENT_T Summary of this function goes here
%   Detailed explanation goes here

    alphabet_size = 26;

    num_words = size(word_list,2);
    tGrads = zeros(alphabet_size, alphabet_size);

    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, logz] = get_forward_memo_mat(x, w, T);
        [B, junk] = get_backwards_memo_mat(x, w, T);
        wordLength = length(y);

        % trying to minimize number of transformations by remapping the
        % vectors out from the loops
        featureF = repmat(F, [alphabet_size,1]);
        featureT1 = repmat(T, [alphabet_size,1]);
        featureB = get_cached_feature_B(B, alphabet_size);
        featureT2 = get_cached_featured_T2(T, alphabet_size);


        % pre compute the dot products, and avoid repetitions
        dotW_Xs = sum(bsxfun(@times, w, x(:,1)));

        for s = 1 : wordLength - 1

            % pre compute dot product of next word, and cache columns
            dotW_Xs1 = sum(bsxfun(@times, w, x(:,s+1)));
            
            % cache here some more colums to avoid indexing in range inside
            % loops, as they are expensive
            if (s>1 && s<wordLength-1) 
                Fjminus1 = featureF(:,s-1); 
                Bjplus2 = featureB(:,s+2);
            else
                Fjminus1 = 0; 
                Bjplus2=0;
            end

            for i = 1 : alphabet_size
                featT1 = featureT1(:, i); %Twj

                for j = 1 : alphabet_size
                    indicator = (y(s) == i && y(s+1) == j);
                    dotWX = dotW_Xs(i) + dotW_Xs1(j);
                    p = calc_probYjYj_1_X(Fjminus1, Bjplus2, B, featureF, featureB, logz, T, featT1, featureT2, dotWX, T(i, j), i, j, s, wordLength, alphabet_size);
                    tGrads(i, j) = tGrads(i, j) + indicator - p;
                end
            end

            % save calculation for next iteration
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

