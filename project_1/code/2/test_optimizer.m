global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

X = importdata(strcat(pwd,'/code/2/model.txt'));
%accuracy = ref_optimize(train_data, test_data, c)
[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));
data = matfile(strcat(pwd,'/code/2/test.mat'));
test_words = data.words;

trainData = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = trainData.words;

% build a small case
NUM_LETTERS = 3;
% alphabet_size = 3;

% train_words{1}.image = train_words{1}.image(:,1:2);
% train_words{1}.letter_number = [1 3];
% 
% train_words{2}.image = train_words{2}.image(:,1:3);
% train_words{2}.letter_number = [1 3 2];
% 
% train_words{3}.image = train_words{3}.image(:,1:3);
% train_words{3}.letter_number = [1 3 2];
% 
% word_list = {};
% word_list{1} = train_words{1};
% word_list{2} = train_words{2};
% word_list{3} = train_words{3};
% 
% test_words{1}.image = test_words{1}.image(:,1:3);
% test_words{1}.letter_number = [1 3 1];
% 
% test_words{2}.image = test_words{2}.image(:,1:2);
% test_words{2}.letter_number = [3 1];
% 
% test_words{3}.image = test_words{3}.image(:,1:3);
% test_words{3}.letter_number = [2 3 1];
% 
% test_list = {};
% test_list{1} = test_words{1};
% test_list{2} = test_words{2};
% test_list{3} = test_words{3};

% train_words{1}.image
% train_words{1}.letter_number
% return;

alphabet_size = 26;
word_list = {};
test_list = {};
for i = 1 : 100
    word_list{i} = {};
    word_list{i}.image = train_words{i}.image;
    word_list{i}.letter_number = train_words{i}.letter_number;

    test_list{i} = {};
    test_list{i}.image = word_list{i}.image;
    test_list{i}.letter_number = word_list{i}.letter_number;
end

c = 00;

accuracy = ref_optimize(word_list, test_list, c, alphabet_size);
accuracy