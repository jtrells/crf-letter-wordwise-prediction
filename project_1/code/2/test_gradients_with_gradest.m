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

% words{1}.image = words{1}.image(:,1:2);
% words{1}.letter_number = [1 3];
% 
% words{2}.image = words{2}.image(:,1:3);
% words{2}.letter_number = [1 3 2];
% 
% words{3}.image = words{3}.image(:,1:3);
% words{3}.letter_number = [1 1 2];


word_list = {};
% for i = 1 : 3
%     word_list{i} = words{i};
% end
% word_list{1} = words{1};
%word_list{2} = words{2};
%word_list{3} = words{3};

word_list{1} = words{2}; % 9 letters
word_list{2} = words{4}; % 9 letters 

alphabet_size = 26;

errW = 0;
errT = 0;

% test with randomly generated values
T_random = randn(alphabet_size ^ 2, 1);
W_random = randn(alphabet_size * 128, 1);
WT = [W_random; T_random];

W_random_reshaped = reshape(W_random, 128, alphabet_size);
T_random_reshaped = reshape(T_random, alphabet_size, alphabet_size);

gT = get_gradient_t(word_list, W_random_reshaped, T_random_reshaped, alphabet_size);
gW = get_gradient_w(word_list, W_random_reshaped, T_random_reshaped, alphabet_size);

% fgT = @(T_col) get_log_prob_gradest_t( T_col, word_list, W_random_reshaped, alphabet_size );
% [gradT,errT,finaldeltaT] = gradest(fgT,T_random);
% gTgradest = reshape(gradT, alphabet_size, alphabet_size);
% 
% fgW = @(W_col) get_log_prob_gradest_w( W_col, word_list, T_random_reshaped, alphabet_size );
% [gradW,errW,finaldeltaW] = gradest(fgW,W_random);
% gWgradest = reshape(gradW, 128, alphabet_size);

fg = @(WT_col) get_log_prob_gradest( WT_col, word_list, alphabet_size );
[gradWT,errW,finaldeltaW] = gradest(fg,WT);
gWgradest = reshape(gradWT(1:128*alphabet_size), 128, alphabet_size); 
gTgradest = reshape(gradWT(128*alphabet_size+1:end), alphabet_size, alphabet_size);

diffgW = abs(gW - gWgradest);
diffgT = abs(gT - gTgradest);

sum(sum(diffgW))
sum(sum(diffgT))