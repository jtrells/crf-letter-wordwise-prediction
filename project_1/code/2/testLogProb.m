% Nice explanation of log trick for p(Y|X)
% https://stats.stackexchange.com/questions/105602/example-of-how-the-log-sum-exp-trick-works-in-naive-bayes
global WORD_LENGTH LETTER_SIZE NUM_LETTERS ALPHABET;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;
ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

% loading this values only to use X for test. I believe we have
% to report with respect of data/train
[x, junk1, junk2] = loadDecoderSet(strcat(pwd,'\code\2\decode_input.txt')); 

% Load weights and transition from the given model for 2(a)
[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));

data = matfile(strcat(pwd,'\code\2\train_x.mat'));
X = data.X;

word = [18 11 22 17 19];
x_5 = x(:, 1:5);

% calculate numerator with objective function
num = exp(dot(w(:, word(1)), x(:, 1)));
for i = 2 : length(word)
    num = num * exp(T(word(i-1), word(i))) * exp(dot(w(:, word(i)), x(:, i)));
end

% calculate log num with objective function
lognum = dot(w(:,word(1)), x(:, 1));
for i = 2 : length(word)
    lognum = lognum + T(word(i-1), word(i)) + dot(w(:, word(i)), x(:, i));
end

lognumVerify = log(num);


% calculate Z
[F, logz, B] = logMemo(x_5, w, T);
log_p_y_x = lognum - logz;


[F_] = forwardBackwardsNoTrick(x, w, T);
z = sum(F_(:, 5));
logzVerify = log(z);

p_y_x = num / z;

log_p_y_xVerify = log(p_y_x);