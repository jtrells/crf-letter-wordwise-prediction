global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

train_data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = train_data.words;

alphabet_size = 26;
c = 5000;
accuracy = ref_optimize(train_words, test_words, c, alphabet_size);