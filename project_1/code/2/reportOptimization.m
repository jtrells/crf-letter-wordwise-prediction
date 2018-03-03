global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

X = importdata(strcat(pwd,'\code\2\model.txt'));
%accuracy = ref_optimize(train_data, test_data, c)
[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));
data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
words = data.words;

c = 1000;
%words = words{1:5};
%res = get_crf_obj( words, w, T, c );

ref_optimize(words, [], 1000);