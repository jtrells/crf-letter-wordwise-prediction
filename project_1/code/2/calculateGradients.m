[wGrads, tGrads] = function calculateGradients()
    global NUM_LETTERS LETTER_SIZE;

    LETTER_SIZE = 128;
    NUM_LETTERS = 26;

    %data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
    data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
    words = data.words;
    [w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));
    %[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));

    num_words = size(words, 2);
    sum_logs = 0;

    wGrads = zeros(LETTER_SIZE, 26);
    tGrads = zeros(26, 26);

    for index = 1 : num_words

        word = words{index};
        x = word.image;
        y = word.letter_number;

        [F, B, logz] = logMemo(x, w, T);
        wordLength = length(y);

        for s = 1 : wordLength

            for i = 1 : 26
                indicator = y(s) == i;

                p = calculateYjGivenX(F, B, logz, dot(x(:,s), w(:,i)), T, s, i, wordLength);

                wGrads(:, i) = wGrads(:, i) + (indicator - p) * x(:, s);

                if s < wordLength
                    for j = 1 : 26
                        indicator = (y(s) == i && y(s+1) == j);

                        p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength)

                        tGrads(i, j) = tGrads(i, j) + indicator - p;
                    end
                end
            end
        end
    end
end