function [ wGrads ] = get_gradient_w( word_list, w, T )
    
    LETTER_SIZE = 128;
    alphabet_size = 26;

    num_words = size(word_list,2);
    wGrads = zeros(LETTER_SIZE, 26);

    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, B, logz] = logMemo(x, w, T);
        wordLength = length(y);

        for s = 1 : wordLength
            for letter = 1 : 26
                indicator = y(s) == letter;
                p = calculateYjGivenX(F, B, logz, dot(x(:,s), w(:,letter)), T, s, letter, wordLength, alphabet_size);
                wGrads(:, letter) = wGrads(:, letter) + (indicator - p) * x(:, s);
            end
        end

    end

end

