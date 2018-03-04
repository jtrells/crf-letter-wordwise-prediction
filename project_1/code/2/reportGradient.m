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
wGrads2 = zeros(LETTER_SIZE, 26);

% word = words{1};
% x = word.image;
% y = word.letter_number;
% 
% [F, logz] = get_forward_memo_mat(x, w, T);
% [B, junk] = get_backwards_memo_mat(x, w, T);
% wordLength = length(y);
% 
% wGrads1 = zeros(128, alphabet_size);
% wGrads2 = zeros(128, alphabet_size);
% 
% for m = 1 : 1
% for s = 1 : wordLength
%     for letter = 1 : 26
%         indicator = y(s) == letter;
% 
%         p = calculateYjGivenX(F, B, logz, x(:,s)'* w(:,letter), T, s, letter, wordLength, alphabet_size);
%         p2 = calc_probYj_X(F, B, logz, x(:,s)'* w(:,letter), T, s, letter, wordLength, alphabet_size);
% 
%         wGrads1(:, letter) = wGrads1(:, letter) + (indicator - p) * x(:, s);
%         wGrads2(:, letter) = wGrads2(:, letter) + (indicator - p2) * x(:, s);
%     end
% end
% end

%gW = get_gradient_w(words, w, T);
% [gW, gT] = get_gradients(words, w, T);

% for index = 1 : num_words
% 
%     word = words{index};
%     x = word.image;
%     y = word.letter_number;
% 
%     [F, logz] = get_forward_memo_mat(x, w, T);
%     [B, junk] = get_backwards_memo_mat(x, w, T);
%     wordLength = length(y);
% 
%     % trying to minimize number of transformations
%     featureF = repmat(F, [alphabet_size,1]);
%     featureT1 = repmat(T, [alphabet_size,1]);
%     vLogz = repmat(logz, [alphabet_size ^ 2, 1]);
%     
%     for s = 1 : wordLength
%         for letter = 1 : 26
%             indicator = y(s) == letter;
% 
%             %p2 = calculateYjGivenX(F, B, logz, x(:,s)'* w(:,letter), T, s, letter, wordLength, alphabet_size);
%             p = calc_probYj_X(featureF, B, vLogz, x(:,s)'* w(:,letter), T, featureT1, s, letter, wordLength, alphabet_size);
% 
%             wGrads(:, letter) = wGrads(:, letter) + (indicator - p) * x(:, s);
%             %wGrads2(:, letter) = wGrads2(:, letter) + (indicator - p2) * x(:, s);
%         end
%     end
% end
%save('wGrads_mat.mat', 'wGrads');


tGrads = zeros(26, 26);
tGrads2 = zeros(26, 26);

for index = 1 : num_words

    word = words{index};
    x = word.image;
    y = word.letter_number;

    [F, logz] = get_forward_memo_mat(x, w, T);
    [B, junk] = get_backwards_memo_mat(x, w, T);
    wordLength = length(y);

    Texp = exp(T);
    Bexp = exp(B);
    % trying to minimize number of transformations
    featureF = repmat(exp(F), [alphabet_size,1]);
    featureT1 = repmat(Texp, [alphabet_size,1]);
    %vLogz = repmat(exp(logz), [alphabet_size ^ 2, 1]);
    
    % B case is different
    featureB = [];
    for i = 1 : size(B,2)
        sel = Bexp(:,i)';
        sel = repmat(sel, [alphabet_size,1]);
        featureB = [featureB reshape(sel, alphabet_size ^ 2, 1)];
    end
    
    featureT2 = [];
    for i = 1 : alphabet_size
        sel = Texp(i,:);
        sel = repmat(sel, [alphabet_size,1]);
        featureT2 = [featureT2 reshape(sel, alphabet_size ^ 2, 1)];
    end
    
    % pre compute the dot products, and avoid repetitions
    dotW_Xs = exp(sum(bsxfun(@times, w, x(:,1))));
    
    for s = 1 : wordLength - 1
        
        % pre compute dot product of next word, and cache columns
        % cache here all columns depending on the current letter!!!
        dotW_Xs1 = exp(sum(bsxfun(@times, w, x(:,s+1))));
        
        for i = 1 : alphabet_size
            for j = 1 : alphabet_size
                indicator = (y(s) == i && y(s+1) == j);

                %p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength, alphabet_size);
                %tGrads(i, j) = tGrads(i, j) + indicator - p;
                %dotWX = w(:,i)'*x(:,s) + w(:,j)'*x(:,s+1);
                dotWX = dotW_Xs(i) + dotW_Xs1(j);
                
                p2 = calc_probYjYj_1_X(featureF, featureB, logz, T, featureT1, featureT2, dotWX, T(i, j), i, j, s, wordLength, alphabet_size);
                tGrads2(i, j) = tGrads2(i, j) + indicator - p;
            end
        end
        
        % save calculation for next iteration
        dotW_Xs = dotW_Xs1;
    end

end
% save('tGrads.mat', 'tGrads');
