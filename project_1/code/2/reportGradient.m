% grad_w(log p (y|X)) = sum(([[ys = y]] - p(ys = y|X)) * xs)

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

alphabet_size = 26;
wGrads = zeros(LETTER_SIZE, 26);

for index = 1 : num_words

    word = words{index};
    x = word.image;
    y = word.letter_number;

    [F, logz] = get_forward_memo_mat(x, w, T);
    [B, junk] = get_backwards_memo_mat(x, w, T);
    wordLength = length(y);

    for s = 1 : wordLength

        for letter = 1 : 26
            indicator = y(s) == letter;

            p = calculateYjGivenX(F, B, logz, x(:,s)'* w(:,letter), T, s, letter, wordLength, alphabet_size);

            wGrads(:, letter) = wGrads(:, letter) + (indicator - p) * x(:, s);
        end
    end
end
save('wGrads_mat.mat', 'wGrads');


% tGrads = zeros(26, 26);
% for index = 1 : num_words
% 
%     word = words{index};
%     x = word.image;
%     y = word.letter_number;
% 
%     [F, B, logz] = logMemo(x, w, T);
%     wordLength = length(y);
% 
%     for s = 1 : wordLength - 1
% 
%         for i = 1 : 26
%             for j = 1 : 26
%                 indicator = (y(s) == i && y(s+1) == j);
% 
%                 p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength)
% 
%                 T(i, j) = T(i, j) + indicator - p;
%             end
%         end
%     end
% 
% end
% save('tGrads.mat', 'tGrads');
