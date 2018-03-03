global NUM_LETTERS LETTER_SIZE;

LETTER_SIZE = 128;
NUM_LETTERS = 26;

data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
words = data.words;
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));

word = words{1};
x = word.image;
y = word.letter_number;
% 
% for i = 1 : 10000
%  [F1,logZ1] = get_forward_memo(x, w, T);
%  [F2,logZ2] = get_forward_memo_mat(x, w, T);
% end

for i = 1 : 10000
[B1,logZ1] = get_backwards_memo(x, w, T);
[B2,logZ2] = get_backwards_memo_mat(x, w, T);
end