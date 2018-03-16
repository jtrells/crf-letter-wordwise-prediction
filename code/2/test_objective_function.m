global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

X = importdata(strcat(pwd,'/code/2/model.txt'));
%accuracy = ref_optimize(train_data, test_data, c)
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));
data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
words = data.words;


x = zeros(128*26+26^2,1);
W = reshape(x(1:128*26), 128, 26); % each column of W is w_y (128 dim)
T = reshape(x(128*26+1:end), 26, 26); % T is 26*26
c = 1000;
val = get_crf_obj( words, W, T, c )
