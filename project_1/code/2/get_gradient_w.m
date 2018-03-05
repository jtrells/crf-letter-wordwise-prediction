function gW = get_gradient_w(word_list, w, T, alphabet_size, c)
   
    letter_size = 128;
    num_words = size(word_list,2);
    gW = zeros(letter_size, alphabet_size);    % gradients for W
    
    for index = 1 : num_words
        
        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, junk1] = get_forward_memo_mat_struct2(x, w, T);
        [B, junk2] = get_backwards_memo_mat_struct2(x, w, T);
        wordLength = length(y);
        
        for s = 1 : wordLength
         
            p_prop = zeros(1, alphabet_size);
            for i = 1 : alphabet_size
                p_prop(i) = F(i,s) + B(i,s) + w(:,i)'*x(:,s);
            end
            
            max_p_prop = max(p_prop);
            J = log(sum(exp(p_prop - max_p_prop))) + max_p_prop;

            
%             J = log(sum(exp(p_prop)));
            p = exp(bsxfun(@minus, p_prop, J));
            
            for i = 1 : alphabet_size
                indicator = y(s) == i;
                gW(:,i) = gW(:,i) + (indicator - p(i)) * x(:,s);
            end
         
        end
    
    end
    
    gW = bsxfun(@rdivide, gW, num_words);
    gW = -(c/num_words) * gW + w;
end

