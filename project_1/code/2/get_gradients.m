function [gW, gT] = get_gradients(word_list, w, T)
    
    global NUM_LETTERS LETTER_SIZE;
    
    alphabet_size = NUM_LETTERS;
    gW = zeros(LETTER_SIZE, NUM_LETTERS);
    gT = zeros(NUM_LETTERS, NUM_LETTERS);
    
    num_words = size(word_list, 2);
    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, logz] = get_forward_memo_mat(x, w, T);
        [B, junk] = get_backwards_memo_mat(x, w, T);
        wordLength = length(y);

        % trying to minimize number of transformations
        featureF = repmat(F, [alphabet_size,1]);
        featureT1 = repmat(T, [alphabet_size,1]);
        vLogz = repmat(logz, [alphabet_size ^ 2, 1]);        
        
        for s = 1 : wordLength % for each letter in the word

            for i = 1 : alphabet_size
                % calculate gradient with respect to W
                indicator = y(s) == i;
                p = calc_probYj_X(featureF, B, vLogz, x(:,s)'* w(:,i), T, featureT1, s, i, wordLength, alphabet_size);
                gW(:, i) = gW(:, i) + (indicator - p) * x(:, s);

                if s < wordLength
                    % calculate gradient with respect to T
                    for j = 1 : alphabet_size
                        indicator = (y(s) == i && y(s+1) == j);
                        p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength, alphabet_size);
                        gT(i, j) = gT(i, j) + indicator - p;
                    end
                end
            end
            
        end
        
    end  % for each word  
    
end

