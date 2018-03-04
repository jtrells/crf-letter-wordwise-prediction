function [gW, gT] = get_gradients_tw(word_list, w, T)
    
    alphabet_size = 26; letter_size = 128;
    num_words = size(word_list,2);
    gT = zeros(alphabet_size, alphabet_size);
    gW = zeros(letter_size, alphabet_size);
    
    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, junk1] = get_forward_memo_mat_struct2(x, w, T);
        [B, junk2] = get_backwards_memo_mat_struct2(x, w, T);
        wordLength = length(y);

        dotW_Xs = sum(bsxfun(@times, w, x(:,1))); % cache the dot products
        
        for s = 1 : wordLength - 1
            
            alpha = F(:, s);
            beta  = B(:, s+1);
            dotW_Xs1 = sum(bsxfun(@times, w, x(:,s+1)));
            
            % pre compute the normalizer term J for a given s
            JW = 0; JT = 0;
            % store unnormalized probabilities
            p_prop_t = zeros(alphabet_size, alphabet_size);
            p_prop_w = zeros(1, alphabet_size);
            
            for i = 1 : alphabet_size
                
                p_prop_w(i) = alpha(i) + beta(i) + dotW_Xs(i);
                JW = JW + exp(p_prop_w(i));
                
                % inner loop for T calculations
                for j = 1 : alphabet_size
                    scalars = dotW_Xs(i) + dotW_Xs1(j) + T(i,j);
                    p_prop_t(i,j) = alpha(i) + beta(j) + scalars;
                    
                    JT = JT + exp(p_prop_t(i,j));
                end
                
            end
            
            % get actual probability values
            JT = log(JT); JW = log(JW);
            pW = exp(bsxfun(@minus, p_prop_w, JW));
            pT = exp(bsxfun(@minus, p_prop_t, JT));
            
            for i = 1 : alphabet_size       
                indicatorW = y(s) == i;
                gW(:, i) = gW(:, i) + (indicatorW - pW(i)) * x(:,s);
                
                for j = 1 : alphabet_size
                    indicatorT = (y(s) == i && y(s+1) == j);
                    gT(i, j) = gT(i, j) + indicatorT - pT(i,j);
                end      
            end
            
            dotW_Xs = dotW_Xs1;
        end
        
    end
end