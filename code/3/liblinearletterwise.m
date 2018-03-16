% readtraining file
[train_vector, train_matrix] = libsvmread('train_struct.txt');

%setting c values
params = {};
params{1} = '-c 3.8531e-05'; %1
params{2} = '-c 3.8531e-04'; %10
params{3} = '-c 0.0039'; %100
params{4} = '-c 0.01926'; %500
params{5} = '-c 0.0385'; %1000
params{6} = '-c 0.19265'; %5000
params{7} = '-c 0.3853'; %10000
params{8} = '-c 3.8531'; %100000
params{9} = '-c 4.0457'; %100000

%read test file
[test_vector, test_matrix] = libsvmread('test_struct.txt');
accuracies = [];

for i=1 : length(params)
   %training the model using train files
    model = train(train_vector, train_matrix, params{i});
    [predict_label, accuracy, dec_values] = predict(test_vector, test_matrix, model);
    accuracies = [accuracies; accuracy(1)];
end
accuracies