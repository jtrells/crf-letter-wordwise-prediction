
global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));
data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
word_list = data.words;
x = word_list{1}.image;

tGrads = get_gradient_t( word_list, w, T );

% Set the global alphabet_size variable to 3 to reduce the time needed in
% the test case. I have to get rid of this global variables soon.
% % NUM_LETTERS = 3;
% % 
% % alphabet_size = 3;
% % w = w(:,1:3);
% % t = T(1:3,1:3);
% % x = words{1}.image(:,1:3);
% % y = [2 1 3];
% % num_letters = size(y,2);
% % 
% % 
% % % test gradient i, i+1 for small test case
% % [F, B, logz] = logMemo(x, w, t);
% % wordLength = length(y);
% % tGrads = zeros(alphabet_size, alphabet_size);
% % 
% % for s = 1 : wordLength - 1
% %     for i = 1 : alphabet_size
% %         for j = 1 : alphabet_size
% %             indicator = (y(s) == i && y(s+1) == j);
% %             p = calculateYjYj_1GivenX2(F, B, logz, T, w, x, i, j, s, wordLength, alphabet_size);
% %             tGrads(i, j) = tGrads(i, j) + indicator - p;
% %         end
% %     end
% % end
% % 
% % g = @(T_row) get_log_prob_gradest_t( T_row, y, x, w, alphabet_size );
% % T_row = reshape(t, alphabet_size ^ 2, 1);
% % [gradT,errT,finaldeltaT] = gradest(g,T_row);
% % gradT = reshape(gradT, alphabet_size, alphabet_size);
% % 
% % tGrads - gradT