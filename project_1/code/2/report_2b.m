global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

train_data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = train_data.words;

alphabet_size = 26;
c = 1000;

% Uncomment to run the optimizer, check if you want to print the test
% objective function on each iteration, but it makes everything slower
%accuracy = ref_optimize(train_words, test_words, c, alphabet_size);

% save results
% uncomment to save the new optimal model obtained from ref_optimize
% optimizer_results = matfile(strcat(pwd,'/code/2/optimal_model.mat'));
% optimal_model = optimizer_results.model;
% fileId = fopen('result/solution.txt', 'wt');
% fprintf(fileId, '%d\n',optimal_model');
% fclose(fileId);

% Predict the labes for each letter in the test data set
test_data = matfile(strcat(pwd,'/code/2/test.mat'));
test_words = test_data.words;

optimizer_results = matfile(strcat(pwd,'/code/2/optimal_model.mat'));
optimal_model = optimizer_results.model;
W = reshape(optimal_model(1:128*alphabet_size), 128, alphabet_size); 
T = reshape(optimal_model(128*alphabet_size+1:end), alphabet_size, alphabet_size); 

y_predict = crf_decode( W, T, test_words );
predicted_letters = [];
for i = 1 : length(y_predict)
    predicted_letters = [predicted_letters; y_predict{i}']; 
end
fileId = fopen('result/prediction.txt', 'wt');
fprintf(fileId, '%d\n',predicted_letters');
fclose(fileId);


