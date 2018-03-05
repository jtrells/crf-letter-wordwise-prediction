global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

X = importdata(strcat(pwd,'/code/2/model.txt'));
%accuracy = ref_optimize(train_data, test_data, c)
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));
data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
words = data.words;

% build a small case
NUM_LETTERS = 3;
W_test = w(:,1:3);
T_test = T(1:3,1:3);

words{1}.image = words{1}.image(:,1:2);
words{1}.letter_number = [1 3];

words{2}.image = words{2}.image(:,1:3);
words{2}.letter_number = [1 3 2];

words{3}.image = words{3}.image(:,1:3);
words{3}.letter_number = [1 3 2];

word_list = {};
word_list{1} = words{1};
word_list{2} = words{2};
word_list{3} = words{3};
alphabet_size = 3;

gT = get_gradient_t(word_list, W_test, T_test, alphabet_size);
gW = get_gradient_w(word_list, W_test, T_test, alphabet_size);

fgT = @(T_col) get_log_prob_gradest_t( T_col, word_list, W_test, alphabet_size );
T_col = reshape(T_test, alphabet_size ^ 2, 1);
[gradT,errT,finaldeltaT] = gradest(fgT,T_col);
gTgradest = reshape(gradT, alphabet_size, alphabet_size);

fgW = @(W_col) get_log_prob_gradest_w( W_col, word_list, T_test, alphabet_size );
W_col = reshape(W_test, alphabet_size * LETTER_SIZE, 1);
[gradW,errW,finaldeltaW] = gradest(fgW,W_col);
gWgradest = reshape(gradW, LETTER_SIZE, alphabet_size);

diffgW = abs(gW - gWgradest);
diffgT = abs(gT - gTgradest);

sum(sum(diffgW))
sum(sum(diffgT))