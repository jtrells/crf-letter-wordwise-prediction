function [tGrads] = get_gradient_t_struct2_v2(word_list, w, T)
    alphabet_size = 26;

    num_words = size(word_list,2);
    tGrads = zeros(alphabet_size, alphabet_size);

    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, junk1] = get_forward_memo_mat_struct2(x, w, T);
        [B, junk2] = get_backwards_memo_mat_struct2(x, w, T);
        wordLength = length(y);

        % cache the dot products
        dotW_Xs = sum(bsxfun(@times, w, x(:,1)));
        
        for s = 1 : wordLength - 1
            
            alpha = F(:, s);
            beta  = B(:, s+1);
            dotW_Xs1 = sum(bsxfun(@times, w, x(:,s+1)));
            
            % pre compute the normalizer term J for a given s
            J = 0;
            p_prop = zeros(alphabet_size, alphabet_size);
            
            for i = 1 : alphabet_size
                for j = 1 : alphabet_size
                    scalars = dotW_Xs(i) + dotW_Xs1(j) + T(i,j);
                    p_prop(i,j) = alpha(i) + beta(j) + scalars;
                    
                    J = J + exp(p_prop(i,j));
                end
            end
            J = log(J);
            
            p = bsxfun(@minus, p_prop, J);
            p = exp(p);
            
            for i = 1 : alphabet_size
                for j = 1 : alphabet_size
                    indicator = (y(s) == i && y(s+1) == j);
                    tGrads(i, j) = tGrads(i, j) + indicator - p(i,j);
                end      
            end
            
            dotW_Xs = dotW_Xs1;
        end
        
    end

end