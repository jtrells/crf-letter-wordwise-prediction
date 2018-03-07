% plot the accuracy of the prediction with different values of c for
% question 3(a)
close all;
test_data = matfile(strcat(pwd,'/code/2/test.mat'));
test_words = test_data.words;

train_data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = train_data.words;

c_values = [1 10 100 500 1000 5000];
alphabet_size = 26;
x = []; y_letters_crf = []; y_words_crf = []; % plot values
y_letters_crf_train = []; y_words_crf_train= [];

for i = 1 : length(c_values)
    model_filename = ...
        strcat(pwd, '/code/3/optimal_model_', num2str(c_values(i)), '.mat');
    model_mat = matfile(model_filename);
    
    [accuracy_letters, accuracy_words] = ...
        crf_test_out(model_mat.model, test_words, alphabet_size);
    x = [x c_values(i)];
    y_letters_crf = [y_letters_crf accuracy_letters];
    y_words_crf   = [y_words_crf accuracy_words];
    
    [accuracy_train_letters, accuracy_train_words] = ...
        crf_test_out(model_mat.model, train_words, alphabet_size);
    y_letters_crf_train = [y_letters_crf_train accuracy_train_letters];
    y_words_crf_train   = [y_words_crf_train accuracy_train_words];
end

% values obtained from other models
y_letters_svm_hmm = [0.355, 0.5905, 0.6844, 0.7195, 0.7333, 0.7403];
y_letters_liblinear = [0.4835, 0.6117, 0.6807, 0.6946, 0.6971, 0.6995];
y_words_svm_hmm = [0.1350, 0.2649, 0.4144, 0.4629, 0.4775, 0.4932];
y_words_liblinear = [0.2832, 0.29, 0.3383, 0.3943, 0.4210, 0.5221];

figure('NumberTitle', 'off', 'Name', 'Letter-wise Accuracy'); 
plot(x, y_letters_crf, 'b-*', ...
     x, y_letters_liblinear, 'k-*', ...
     x, y_letters_svm_hmm, 'r-+');
ax = gca;
set(gca,'XTick',x);
set(gca,'XLim', [-100 5100]);
set(gca,'YLim', [0 1]);
xlabel('C')
ylabel('accuracy');
legend('CRF', 'SVM-MC', 'SVM-Struct');

figure('NumberTitle', 'off', 'Name', 'Word-wise Accuracy');
plot(x, y_words_crf, 'b-o', ...
     x, y_words_liblinear, 'k-*', ...
     x, y_words_svm_hmm, 'r-+');
ax = gca;
set(gca,'XTick',x);
set(gca,'XLim', [-100 5100]);
set(gca,'YLim', [0 1]);
xlabel('C')
ylabel('accuracy');
legend('CRF', 'SVM-MC', 'SVM-Struct');

% hold on
% for ii = 1:length(x)
%     text(x(ii),y_letters(ii),num2str(y_letters(ii)),'Color','r')
% end
