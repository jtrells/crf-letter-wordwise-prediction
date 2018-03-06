function gT = get_gradient_t(word_list, w, T, alphabet_size, c)
    
    num_words = size(word_list,2);
    gT = zeros(alphabet_size, alphabet_size);  % gradients for T
    
    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, junk1] = get_forward_memo_mat_struct2(x, w, T);
        [B, junk2] = get_backwards_memo_mat_struct2(x, w, T);
        wordLength = length(y);

        dotW_Xs = sum(bsxfun(@times, w, x(:,1))); % cache the dot products, sum(elemt-wise prod)
        
        for s = 1 : wordLength - 1
  
            dotW_Xs1 = sum(bsxfun(@times, w, x(:,s+1))); % sum(elemt-wise prod)
            % pre compute the normalizer term J for a given s
%             J = 0;
            % store unnormalized probabilities
            p_prop_t = zeros(alphabet_size, alphabet_size);
            
            for i = 1 : alphabet_size
                for j = 1 : alphabet_size
                    scalars = dotW_Xs(i) + dotW_Xs1(j) + T(i,j);
                    p_prop_t(i,j) = F(i,s) + B(j,s+1) + scalars;                    
                end
            end
            
            max_p_prop = max(max(p_prop_t));
            J = log(sum(sum(exp(p_prop_t - max_p_prop)))) + max_p_prop;
            
            % get actual probability values
            pT = exp(bsxfun(@minus, p_prop_t, J));
            
            for i = 1 : alphabet_size                       
                for j = 1 : alphabet_size
                    indicatorT = (y(s) == i && y(s+1) == j);
                    gT(i, j) = gT(i, j) + indicatorT - pT(i,j);
                end      
            end
            
            dotW_Xs = dotW_Xs1;
        end
        
    end
    
    %gT = bsxfun(@rdivide, gT, num_words);
    gT = -(c/num_words) * gT + T; 
end