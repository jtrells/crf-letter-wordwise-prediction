global NUM_LETTERS LETTER_SIZE;

LETTER_SIZE = 128;
NUM_LETTERS = 26;

data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
words = data.words;
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));

word = words{1};
x = word.image;
y = word.letter_number;

[F1,logZ1] = get_forward_memo(x, w, T);
[F2,logZ2] = get_forward_memo_mat(x, w, T);