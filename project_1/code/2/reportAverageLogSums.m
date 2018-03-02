global NUM_LETTERS LETTER_SIZE;

LETTER_SIZE = 128;
NUM_LETTERS = 26;

data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
words = data.words;
[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));

num_words = size(words, 2);
sum_logs = 0;
for index = 1 : num_words
    
    word = words{index};
    x = word.image;
    y = word.letter_number;
    
    sum_logs = sum_logs + getLogProbYGivenX( y, x, w, T );
end

sum_logs/num_words
% -30.9267
