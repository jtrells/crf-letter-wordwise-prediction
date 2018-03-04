global NUM_LETTERS LETTER_SIZE;

LETTER_SIZE = 128;
NUM_LETTERS = 26;

%data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
words = data.words;
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));

alphabet_size = 26;

word = words{1};
x = word.image;
y = word.letter_number;

% all memos with the different types of calculations should give the same
% logZ
[F1, logz1] = get_forward_memo_mat(x, w, T);
[F2, logz2] = get_forward_memo_mat_struct2(x, w, T);
[F3, logz3] = get_forward_memo(x, w, T);

[B1, logBz1] = get_backwards_memo_mat(x, w, T);
[B2, logBz2] = get_backwards_memo_mat_struct2(x, w, T);
[B3, logBz3] = get_backwards_memo(x, w, T);