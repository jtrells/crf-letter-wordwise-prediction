% Read train file 
[train_vector, train_matrix] = libsvmread('train_struct.txt');

% All test transformed test files
params = {};
params{1} = 'data_python/letters_500.txt'; %500 tranformed Lines
params{2} = 'data_python/letters_1000.txt'; %1000 tranformed Lines
params{3} = 'data_python/letters_1500.txt'; %1500 tranformed Lines
params{4} = 'data_python/letters_2000.txt'; %2000 tranformed Lines

%Training value with best c value
model = train(train_vector, train_matrix, '-c 3.8531');
accuracies = [];
for i=1 : length(params)
    [test_vector, test_matrix] = libsvmread(params{i});
    [predict_label, accuracy, dec_values] = predict(test_vector, test_matrix, model);
    accuracies = [accuracies; accuracy(1)];
end
accuracies
