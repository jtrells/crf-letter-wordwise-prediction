function [ wGrads ] = get_gradient_w( word_list, w, T )
    
    LETTER_SIZE = 128;
    alphabet_size = 26;

    num_words = size(word_list,2);
    wGrads = zeros(LETTER_SIZE, 26);

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
        
        for s = 1 : wordLength
            for letter = 1 : 26
                indicator = y(s) == letter;
                p = calc_probYj_X(featureF, B, vLogz, x(:,s)'* w(:,letter), T, featureT1, s, letter, wordLength, alphabet_size);
                wGrads(:, letter) = wGrads(:, letter) + (indicator - p) * x(:, s);
            end
        end

    end

end

