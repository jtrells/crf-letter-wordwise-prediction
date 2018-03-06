%[label_vector, instance_matrix] = libsvmread('train_struct_parsed.txt');
%model = train(label_vector, instance_matrix, '-c 1');
% 
% [train_vector, train_matrix] = libsvmread('test_struct_letters.txt');
% [predict_label, accuracy, dec_values] = predict(train_vector, train_matrix, model); % test the training data


params = {};
params{1} = '-c 3.8531e-05';
params{2} = '-c 3.8531e-04';
params{3} = '-c 0.0039';
params{4} = '-c 0.0385';
params{5} = '-c 0.3853';
params{6} = '-c 3.8531';


[train_vector, train_matrix] = libsvmread('train_struct_parsed.txt');
accuracies = [];

for i=1 : length(params)
    model = train(train_vector, train_matrix, params{i});
    [predict_label, accuracy, dec_values] = predict(train_vector, train_matrix, model);
    accuracies = [accuracies; accuracy(1)];
end
accuracies
