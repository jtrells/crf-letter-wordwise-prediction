close all;

test_data = matfile(strcat(pwd,'/code/2/test.mat'));
test_words = test_data.words;

transformed_data = matfile(strcat(pwd,'/code/4/transformed_test_data_no_pad.mat'));
transformed_test_words = transformed_data.train_words;

test_samples = [0 500 1000 1500 2000];
alphabet_size = 26;
x = []; y_letters_crf = []; y_words_crf = []; % plot values

% choose an specific c
c = 500;
model_filename = strcat(pwd, '/code/3/optimal_model_500.mat');
model_mat = matfile(model_filename);


for i = 1 : length(test_samples)
    
    prediction_set = {};
    if test_samples(i) == 0
        prediction_set = test_words;
    else
        for j = 1 : test_samples(i)
            prediction_set{j} = transformed_test_words{j}; 
        end
        for j = 1 + test_samples(i) : length(test_words)
            prediction_set{j} = test_words{j};
        end
    end
    
    [accuracy_letters, accuracy_words] = ...
        crf_test_out(model_mat.model, prediction_set, alphabet_size);
    y_letters_crf = [y_letters_crf accuracy_letters];
    y_words_crf   = [y_words_crf accuracy_words];
    
end

figure('NumberTitle', 'off', 'Name', 'Letter-wise Accuracy'); 
plot(test_samples, y_letters_crf, 'b-*');
ax = gca;
set(gca,'XTick',test_samples);
set(gca,'YLim', [0 1]);
xlabel('x')
ylabel('accuracy');
legend('CRF', 'SVM-MC', 'CRF-Train');
