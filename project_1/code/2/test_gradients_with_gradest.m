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

words{2}.image = words{2}.image(:,1:3);
words{2}.letter_number = [1 3 2];

word_list = {};
word_list{1} = words{2};
alphabet_size = 3;

gT = get_gradient_t(word_list, W_test, T_test, alphabet_size);
gW = get_gradient_w(word_list, W_test, T_test, alphabet_size);

fgT = @(T_col) get_log_prob_gradest_t( T_col, word_list{1}.letter_number, word_list{1}.image, W_test, alphabet_size );
T_col = reshape(T_test, alphabet_size ^ 2, 1);
[gradT,errT,finaldeltaT] = gradest(fgT,T_col);
gTgradest = reshape(gradT, alphabet_size, alphabet_size);

fgW = @(W_col) get_log_prob_gradest_w( W_col, word_list{1}.letter_number, word_list{1}.image, T_test, alphabet_size );
W_col = reshape(W_test, alphabet_size * LETTER_SIZE, 1);
[gradW,errW,finaldeltaW] = gradest(fgW,W_col);
gWgradest = reshape(gradW, LETTER_SIZE, alphabet_size);

diffgW = abs(gW - gWgradest);
diffgT = abs(gT - gTgradest);

sum(sum(diffgW))
sum(sum(diffgT))