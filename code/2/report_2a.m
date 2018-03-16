global NUM_LETTERS LETTER_SIZE;
NUM_LETTERS = 26;
LETTER_SIZE = 128;

[w, T] = loadModel(strcat(pwd,'/code/2/model.txt'));
alphabet_size = 26;

% data from data/train.txt
train_data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
word_list = train_data.words;

% Compute the average gradient 1/n * (sum gradient_logPyX_w)
% Reusing the gradient of the objective function but substracting W and
% multiplying by c = -1 to get the gradient only for log(P(y|x))
gW = get_gradient_w(word_list, w, T, alphabet_size, -1);
% gW = (-c/n)sum(grad(P(Y|X))) + W
gW = gW - w; % and this gives (1/n)sum(grad(P(Y|X))) 

% Compute the average gradient 1/n * (sum logPxY_T) over the train data
% Reusing the grad from the objective function as with gW
gT = get_gradient_t(word_list, w, T, alphabet_size, -1); % gT = -(c/num_words) * gT + T; 
gT = gT - T;

% Save in result/gradient.txt as a column vector for gradW and gradT
grad_result = [ reshape(gW, 128 * alphabet_size,1); ...
                reshape(gT, alphabet_size ^ 2, 1) ];
fileId = fopen('result/gradient.txt', 'wt');
fprintf(fileId, '%d\n',grad_result');
fclose(fileId);
            
% Report 1/n sum logPyX in the report
log_prob = 0;
for i = 1 : length(word_list)
    y = word_list{i}.letter_number;
    x = word_list{i}.image;
    log_prob = log_prob + getLogProbYGivenX( y, x, w, T );
end
log_prob = log_prob/length(word_list);

% From 3438 words in the train data
fprintf('Average Log-Likelihood %g\n', log_prob);

