function [ tGrads ] = get_gradient_t( word_list, w, T )
%GET_GRADIENT_T Summary of this function goes here
%   Detailed explanation goes here
    
    alphabet_size = 26;
    num_words = size(word_list,2);
    tGrads = zeros(alphabet_size, alphabet_size);
    
    for index = 1 : num_words

        word = word_list{index};
        x = word.image;
        y = word.letter_number;

        [F, B, logz] = logMemo(x, w, T);
        wordLength = length(y);

        for s = 1 : wordLength - 1
            for i = 1 : 26
                for j = 1 : 26
                    indicator = (y(s) == i && y(s+1) == j);
                    p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength, alphabet_size);
                    tGrads(i, j) = tGrads(i, j) + indicator - p;
                end
            end
        end

    end

end

