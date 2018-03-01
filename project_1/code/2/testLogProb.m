% Nice explanation of log trick for p(Y|X)
% https://stats.stackexchange.com/questions/105602/example-of-how-the-log-sum-exp-trick-works-in-naive-bayes
global WORD_LENGTH LETTER_SIZE NUM_LETTERS ALPHABET;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;
ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

% loading this values only to use X for test. I believe we have
% to report with respect of data/train
[x, junk1, junk2] = loadDecoderSet('/data/decode_input.txt'); 

% Load weights and transition from the given model for 2(a)
[w, T] = loadModel('/data/model.txt');
[F, B, log_Z] = forward_backwards(x, w, T);

[F_] = forwardBackwardsNoTrick(x, w, T);

% calculate numerator
% assume for test a word of 5 letters, so let's take the first 5 columns
% for F and recalculate log_Z. The previous value was for m = 100
numerator = 1;
log_Z = sum(F(:,5));
word = [18 11 22 17 19]; % first 5 letters of decoder 1c

for i = 1 : length(word) - 1
    numerator = numerator * exp(dot(w(:,word(i)), x(:,i))) * exp(T(word(i), word(i+1)));
end
numerator = numerator * exp(dot(w(:,word(length(word))), x(:,length(word))));
log_p_y_given_x = numerator/sum(F_(:,5));


numerator2 = 0;
for i = 1 : length(word) - 1
    numerator2 = numerator2 + dot(w(:,word(i)), x(:,i)) + T(word(i), word(i+1));
end
numerator2 = numerator2 + dot(w(:,word(length(word))), x(:,length(word)));

